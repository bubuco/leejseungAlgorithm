import java.util.Stack;

String inputText = "";  // 사용자가 입력 중인 수식
String postfixResult = "";  // 변환된 Postfix 결과
String finalResult = "";    // 최종 계산 결과
boolean errorOccurred = false; // 에러 발생 여부

void setup() {
  size(600, 300);
  textFont(createFont("SansSerif", 16));
}

void draw() {
  background(245);
  
  // 1. 안내 메시지 및 입력창 UI
  fill(50);
  textSize(14);
  text("아래칸에 계산식 입력", 40, 50);
  
  // 입력창 배경
  fill(255);
  stroke(200);
  rect(40, 70, 520, 40, 5);
  
  // 입력 중인 텍스트 표시
  fill(0);
  textSize(18);
  text(inputText + (frameCount % 30 < 15 ? "|" : ""), 50, 96); // 커서 효과 포함
  
  // 2. 결과 출력 UI
  stroke(220);
  line(40, 140, 560, 140);
  
  fill(100);
  textSize(14);
  text("Postfix Expression:", 40, 180);
  text("계산 결과:", 40, 230);
  
  // 실제 결과 값 표시
  fill(0, 102, 204); // 파란색 강조
  textSize(18);
  text(postfixResult, 200, 180);
  
  if (errorOccurred) {
    fill(204, 0, 0); // 에러는 빨간색
    text(finalResult, 200, 230);
  } else {
    fill(0, 153, 76); // 결과는 초록색
    text(finalResult, 200, 230);
  }
  
  // 하단 안내
  fill(150);
  textSize(12);
  text("Press [ENTER] to calculate | Press [BACKSPACE] to delete", 40, 280);
}

// 키보드 입력 처리 함수
void keyReleased() {
  if (key == ENTER || key == RETURN) {
    if (inputText.trim().length() > 0) {
      calculate(inputText.trim());
    }
  } else if (key == BACKSPACE) {
    if (inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    }
  } else if (key != CODED && key != ESC) {
    // 일반 문자(숫자, 연산자, 공백 등) 입력 추가
    inputText += key;
  }
}

// 변환 및 계산 실행 함수
void calculate(String infix) {
  try {
    errorOccurred = false;
    postfixResult = infixToPostfix(infix);
    float res = evaluatePostfix(postfixResult);
    finalResult = String.valueOf(res);
  } catch (Exception e) {
    errorOccurred = true;
    postfixResult = "Error";
    finalResult = "Invalid Expression (Check spaces/brackets)";
  }
}

// 연산자 우선순위
int precedence(char op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  return 0;
}

// Infix -> Postfix 변환
String infixToPostfix(String s) {
  StringBuilder result = new StringBuilder();
  Stack<Character> stack = new Stack<>();
  String[] tokens = s.split("\\s+"); // 연속된 공백도 처리하도록 변경
  
  for (String token : tokens) {
    if (token.isEmpty()) continue;
    char c = token.charAt(0);
    
    // 숫자인 경우 (소수점이나 음수 기호도 고려하여 첫 글자가 숫자이거나, 길이가 길면 숫자로 판단)
    if (Character.isDigit(c) || token.length() > 1) {
      result.append(token).append(" ");
    } else if (c == '(') {
      stack.push(c);
    } else if (c == ')') {
      while (!stack.isEmpty() && stack.peek() != '(') {
        result.append(stack.pop()).append(" ");
      }
      if (!stack.isEmpty() && stack.peek() == '(') stack.pop();
    } else {
      while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
        result.append(stack.pop()).append(" ");
      }
      stack.push(c);
    }
  }
  while (!stack.isEmpty()) {
    result.append(stack.pop()).append(" ");
  }
  return result.toString().trim();
}

// Postfix 계산
float evaluatePostfix(String postfix) {
  Stack<Float> stack = new Stack<>();
  String[] tokens = postfix.split("\\s+");
  
  for (String token : tokens) {
    if (token.isEmpty()) continue;
    char c = token.charAt(0);
    
    if (Character.isDigit(c) || token.length() > 1) {
      stack.push(float(token));
    } else {
      float val2 = stack.pop();
      float val1 = stack.pop();
      switch (c) {
        case '+': stack.push(val1 + val2); break;
        case '-': stack.push(val1 - val2); break;
        case '*': stack.push(val1 * val2); break;
        case '/': stack.push(val1 / val2); break;
      }
    }
  }
  return stack.pop();
}
