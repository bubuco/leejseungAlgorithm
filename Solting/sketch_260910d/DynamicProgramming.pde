int[][] Value = new int[4][100];
int[][] DP = new int[4][100];

void setup() {
  size(400, 400); // Processing 창 크기 설정
  
  int cnt = 5; // 데이터 개수 (예시)
  
  // 예시 입력 데이터 (Value[0], Value[1], Value[2])
  int[][] sampleInput = {
    {10, 20, 30, 25, 15},
    {5,  30, 15, 20, 10},
    {20, 10, 25, 15, 30}
  };
  
  // 입력값 복사
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < cnt; j++) {
      Value[i][j] = sampleInput[i][j];
    }
  }

  // Value[3] 계산 (Value[0] + Value[2])
  for (int i = 0; i < cnt; i++) {
    Value[3][i] = Value[0][i] + Value[2][i];
  }

  // DP 초기값 설정 (첫 번째 열)
  DP[0][0] = Value[0][0];
  DP[1][0] = Value[1][0];
  DP[2][0] = Value[2][0];
  DP[3][0] = Value[3][0];

  // DP 점화식 계산 (두 번째 열부터 끝까지)
  for (int i = 1; i < cnt; i++) {
    DP[0][i] = max(DP[1][i - 1], DP[2][i - 1]) + Value[0][i];
    DP[1][i] = max(max(DP[0][i - 1], DP[2][i - 1]), DP[3][i - 1]) + Value[1][i];
    DP[2][i] = max(DP[0][i - 1], DP[1][i - 1]) + Value[2][i];
    DP[3][i] = DP[1][i - 1] + Value[3][i];
  }

  println("========== DP Table Matrix ==========");
  for (int i = 0; i < 4; i++) {
    print("행 " + i + " : ");
    for (int j = 0; j < cnt; j++) {
      print(DP[i][j] + "\t"); 
    }
    println(); 
  }
  println("=====================================");

  int finalResult = max(max(max(DP[0][cnt - 1], DP[1][cnt - 1]), DP[2][cnt - 1]), DP[3][cnt - 1]);
  println("최종 결과값: " + finalResult);
}

void draw() {
}
