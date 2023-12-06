
// Submission ID: 12476811

#include <cstdio>
#include <iostream>
#include <tuple>
#include <cstring>

#define M 50001

int N, S, L;

int prelit [M];

struct node_t {
    int cc;
    int c[100];
    int d[100];
};

node_t nodes [M];

std::tuple<int, int> mvc_tup(int root, int dist)
{

    int w = 1 - prelit[root], wo = 0;

    if (dist <= 0) return { w, wo };

    auto &nd = nodes[root];
    for (int i = 0; i < nd.cc; i++)
    {
        auto [cw, cwo] = mvc_tup(nd.c[i], dist - nd.d[i]);
        w += std::min(cw, cwo);
        wo += cw;
    }

    return { w, wo };
}

int main()
{
    std::cin >> N >> S;

    N--;
    S /= 2;

    std::memset(nodes, 0, M * sizeof *nodes);

    for (int i = 0; i < N; i++)
    {
        int r, c, d;
        std::cin >> r >> c >> d;
        auto &nd = nodes[r];
        nd.c[nd.cc] = c;
        nd.d[nd.cc] = d;
        nd.cc++;
    }

    std::cin >> L;
    std::memset(prelit, 0, L * sizeof *prelit);

    while (L--)
    {
        int i;
        std::cin >> i;
        prelit[i] = 1;
    }

    auto [w, wo] = mvc_tup(1, S);

    std::cout << std::min(w, wo);
}
