import java.util.ArrayList;

class PEdge {
  int u, v, w;
  boolean selected = false;

  PEdge(int u, int v, int w) {
    this.u = u;
    this.v = v;
    this.w = w;
  }
}

float[][] pos = {
  {180, 150},
  {340, 100},
  {500, 150},
  {220, 300},
  {460, 300}
};

int[][] rawEdges = {
  {0, 1, 4},
  {0, 3, 2},
  {1, 2, 5},
  {1, 3, 1},
  {1, 4, 7},
  {2, 4, 3},
  {3, 4, 6}
};

ArrayList<PEdge> edges;
boolean[] inMST;
int mstCount = 0;
PEdge lastAdded = null;
boolean done = false;

void setup() {
  size(720, 440);
  textAlign(CENTER, CENTER);
  resetPrim();
}

void resetPrim() {
  int n = pos.length;
  inMST = new boolean[n];
  edges = new ArrayList<PEdge>();
  for (int[] e : rawEdges) {
    edges.add(new PEdge(e[0], e[1], e[2]));
  }

  inMST[0] = true;
  mstCount = 0;
  lastAdded = null;
  done = false;
}

void stepPrim() {
  if (done) return;

  int n = pos.length;
  if (mstCount >= n - 1) {
    done = true;
    return;
  }

  PEdge bestEdge = null;
  int nextVertex = -1;

  for (PEdge e : edges) {
    if (e.selected) continue;
    boolean uIn = inMST[e.u];
    boolean vIn = inMST[e.v];

    if (uIn != vIn) {
      if (bestEdge == null || e.w < bestEdge.w) {
        bestEdge = e;
        nextVertex = uIn ? e.v : e.u;
      }
    }
  }

  if (bestEdge == null) {
    done = true;
    return;
  }

  bestEdge.selected = true;
  inMST[nextVertex] = true;
  lastAdded = bestEdge;
  mstCount++;

  if (mstCount == n - 1) {
    done = true;
  }
}

void draw() {
  background(248);

  for (PEdge e : edges) {
    float x1 = pos[e.u][0], y1 = pos[e.u][1];
    float x2 = pos[e.v][0], y2 = pos[e.v][1];

    if (e == lastAdded) {
      stroke(255, 140, 0);
      strokeWeight(4.5);
    } else if (e.selected) {
      stroke(40, 170, 90);
      strokeWeight(4);
    } else {
      stroke(155);
      strokeWeight(2);
    }
    line(x1, y1, x2, y2);

    float mx = (x1 + x2) / 2;
    float my = (y1 + y2) / 2 - 12;
    fill(255);
    noStroke();
    rect(mx - 14, my - 10, 28, 20, 4);
    fill(20);
    textSize(13);
    text(e.w, mx, my);
  }

  for (int i = 0; i < pos.length; i++) {
    fill(inMST[i] ? color(155, 225, 170) : color(255));
    stroke(40);
    strokeWeight(2);
    ellipse(pos[i][0], pos[i][1], 46, 46);

    fill(0);
    textSize(15);
    text(i, pos[i][0], pos[i][1]);
  }
}

void mousePressed() { stepPrim(); }
void keyPressed() {
  if (key == ' ') stepPrim();
  else if (key == 'r' || key == 'R') resetPrim();
}
