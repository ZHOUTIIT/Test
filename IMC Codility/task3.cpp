int solution(vector<int>& A, int K) {
    int n = A.size();
    int best = 0;
    int count = 1;
    for (int i = 0; i < n - K - 1; i++) {
        if (A[i] == A[i + 1])
            count = count + 1;
        else{
        best = max(best, count);
        count = 1;
      }
    }
    int result = best + K;

    return result;
}
