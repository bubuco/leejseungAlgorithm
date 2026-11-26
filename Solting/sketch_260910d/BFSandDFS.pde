import java.util.ArrayList;

class GraphData {
  float[][] pos;
  int[][] adj;

  GraphData(float[][] pos, int[][] adj) {
    this.pos = pos;
    this.adj = adj;
  }
}

GraphData[] graphs;
int gIdx = 0;
boolean isDFS = false;

boolean[] visited;
ArrayList<Integer> frontier;
ArrayList<Integer> order;
int current = -1;
int startIdx = 0;
boolean done = false;

void setup() {
  size(760, 500);
  textAlign(CENTER, CENTER);
  initGraphs();
  resetState();
}

void initGraphs() {
  graphs = new GraphData[4];

  graphs[0] = new GraphData(
    new float[][] {
      {180, 270},
      {180, 130},
      {330, 130},
      {330, 270},
      {470, 200}
    },
    new int[][] {
      {1, 2},
      {0, 2},
      {0, 1, 3, 4},
      {2},
      {2}
    }
  );

  graphs[1] = new GraphData(
    new float[][] {
      {280, 260},
      {160, 130},
      {280, 130},
      {160, 260},
      {430, 130},
      {430, 260}
    },
    new int[][] {
      {2, 3},
      {2},
      {0, 1},
      {0},
      {5},
      {4}
    }
  );

  graphs[2] = new GraphData(
    new float[][] {
      {380, 100},
      {230, 200},
      {380, 200},
      {530, 200},
      {380, 300}
    },
    new int[][] {
      {1, 2, 3},
      {0},
      {0, 4},
      {0},
      {2}
    }
  );

  graphs[3] = new GraphData(
    new float[][] {
      {180, 130},
      {300, 130},
      {240, 250},
      {430, 130},
      {430, 250},
      {540, 190}
    },
    new int[][] {
      {1, 2},
      {0, 2},
      {0, 1},
      {4},
      {3},
      {}
    }
  );
}

void resetState() {
  int n = graphs[gIdx].adj.length;
  visited = new boolean[n];
  frontier = new ArrayList<Integer>();
  order = new ArrayList<Integer>();
  current = -1;
  startIdx = 0;
  done = false;
}

void step() {
  if (done) return;

  int[][] adj = graphs[gIdx].adj;
  int n = adj.length;

  if (frontier.isEmpty()) {
    while (startIdx < n && visited[startIdx]) {
      startIdx++;
    }
    if (startIdx >= n) {
      current = -1;
      done = true;
      return;
    }
    visited[startIdx] = true;
    frontier.add(startIdx);
    startIdx++;
  }

  if (!isDFS) {
    current = frontier.remove(0);
  } else {
    current = frontier.remove(frontier.size() - 1);
  }
  order.add(current);

  int[] neighbors = adj[current];
  if (!isDFS) {
    for (int i = 0; i < neighbors.length; i++) {
      int next = neighbors[i];
      if (!visited[next]) {
        visited[next] = true;
        frontier.add(next);
      }
    }
  } else {
    for (int i = neighbors.length - 1; i >= 0; i--) {
      int next = neighbors[i];
      if (!visited[next]) {
        visited[next] = true;
        frontier.add(next);
      }
    }
  }

  boolean allDone = frontier.isEmpty();
  for (int i = 0; i < n; i++) {
    if (!visited[i]) allDone = false;
  }
  if (allDone) done = true;
}

void draw() {
  background(248);
  GraphData g = graphs[gIdx];

  stroke(150);
  strokeWeight(2.5);
  for (int u = 0; u < g.adj.length; u++) {
    for (int v : g.adj[u]) {
      if (u < v) {
        line(g.pos[u][0], g.pos[u][1], g.pos[v][0], g.pos[v][1]);
      }
    }
  }

  for (int i = 0; i < g.pos.length; i++) {
    if (i == current) {
      fill(255, 165, 60);
    } else if (visited[i]) {
      fill(130, 210, 150);
    } else {
      fill(255);
    }

    stroke(40);
    strokeWeight(2);
    ellipse(g.pos[i][0], g.pos[i][1], 46, 46);

    fill(0);
    textSize(16);
    text(i, g.pos[i][0], g.pos[i][1]);
  }

  for (int i = 0; i < visited.length; i++) {
    float x = 50 + i * 54;
    float y = 370;
    fill(visited[i] ? color(130, 210, 150) : color(255));
    stroke(60);
    rect(x, y, 44, 44, 5);

    fill(0);
    textSize(12);
    text(i + ":" + (visited[i] ? "T" : "F"), x + 22, y + 22);
  }

  textAlign(LEFT, CENTER);
  textSize(14);
  fill(30);
  text((isDFS ? "DFS " : "BFS ") + frontier.toString(), 50, 442);
  text(order.toString(), 50, 470);
  textAlign(CENTER, CENTER);
}

void mousePressed() {
  step();
}

void keyPressed() {
  if (key == '1') { gIdx = 0; resetState(); }
  else if (key == '2') { gIdx = 1; resetState(); }
  else if (key == '3') { gIdx = 2; resetState(); }
  else if (key == '4') { gIdx = 3; resetState(); }
  else if (key == 'b' || key == 'B') { isDFS = false; resetState(); }
  else if (key == 'd' || key == 'D') { isDFS = true; resetState(); }
  else if (key == 'r' || key == 'R') { resetState(); }
  else if (key == ' ') { step(); }
}
