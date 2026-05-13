#include <iostream>
#include <vector>
#include <algorithm>

static bool readArray(const std::string& name, std::vector<int>& arr, int n) {
    std::cout << n << " numbers for array " << name << ": ";
    for (int i = 0; i < n; ++i) {
        if (!(std::cin >> arr[i])) {
            std::cerr << "Error: element " << (i + 1) << " of array " << name
                      << " is not a valid integer" << std::endl;
            return false;
        }
    }
    return true;
}

int main() {
    const int N = 10;
    std::vector<int> X(N), Y(N), Z;

    if (!readArray("X", X, N)) return 1;
    if (!readArray("Y", Y, N)) return 1;

    int maxY = *std::max_element(Y.begin(), Y.end());
    int minX = *std::min_element(X.begin(), X.end());

    for (int v : X) if (v > maxY) Z.push_back(v);
    for (int v : Y) if (v < minX) Z.push_back(v);

    std::cout << "Array Z: ";
    if (Z.empty()) std::cout << "-";
    else for (int v : Z) std::cout << v << " ";
    std::cout << std::endl;
    return 0;
}
