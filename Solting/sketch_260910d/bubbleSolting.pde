int[] arr;



void setup() {
  intArr(16);
  printArr();
  BubbleSorting();
  printArr();
}

void swap(int i, int j) {
  int tmp;
  tmp = arr[j];
    arr[j] = arr[i];
    arr[i] = tmp;
}

void intArr(int n) {
  int i;
  arr = new int[n];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
}

void printArr() {
  int i;
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }
  println();
}

void BubbleSorting() {
  int i,j, change;
  boolean swapped;
  
  for(i=0; i<arr.length-1; i++) {
    swapped = false;
    for (j=0; j<arr.length -1-i; j++) {
      if (arr[j] > arr[j+1]) {
        swap(j, j +1);
        swapped = true;
      }
    }
    if (!swapped) {
    break;
  }
  }
}
