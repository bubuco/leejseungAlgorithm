int[] arr;

void setup() {
  intArr(16);
  printArr();
  insertionSoritng();
  printArr();
}

void printArr() {
  int i;
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }
  println();
}

void intArr(int n) {
  int i;
  arr = new int[n];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
}

void swap(int i, int j) {
  int tmp;
  tmp = arr[j];
    arr[j] = arr[i];
    arr[i] = tmp;
  
}

void insertionSoritng() {
  int i, j, target;
  for (i=1; i< arr.length; i++) {
    target = arr[i];
    j = i -1;
    
    while (j >= 0 && arr[j] > target) {
      arr[j+1] = arr[j];
      j--;
    }
    arr[j+1] = target;
  }
}
