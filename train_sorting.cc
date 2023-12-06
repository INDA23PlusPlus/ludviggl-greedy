
// Submission ID: 12474067

#include <iostream>
#include <vector>
#include <algorithm>

struct car_t { int w, i, dl, il, mdl, mil; };

inline auto cmp(const car_t &lhs, const car_t &rhs)
{
    return lhs.w < rhs.w;
}

int main()
{
    int n;
    std::cin >> n;

    auto cars = new car_t[n];

    for (int i = 0; i < n; i++)
    {
        car_t c;
        c.i = i;
        std::cin >> c.w;
        cars[i] = c;
    }

    std::sort(cars, cars + n, cmp);

    int mdl = 0, mil = 0;

    for (int i = 0; i < n; i++)
    {
        cars[i].dl = 1;

        for (int j = 0; j < i; j++)
        {
            if (cars[j].i > cars[i].i && cars[j].dl + 1 > cars[i].dl)
            {
                cars[i].dl = cars[j].dl + 1;
            }
        }

        if (mdl < cars[i].dl)
        {
            mdl = cars[i].dl;
        }

        cars[i].mdl = mdl;
    }

    for (int i = n - 1; i >= 0; i--)
    {
        cars[i].il = 1;

        for (int j = n - 1; j >= i; j--)
        {
            if (cars[j].i > cars[i].i && cars[j].il + 1 > cars[i].il)
            {
                cars[i].il = cars[j].il + 1;
            }
        }

        if (mil < cars[i].il)
        {
            mil = cars[i].il;
        }

        cars[i].mil = mil;
    }

    int m = 0;

    if (cars[0].mil > m) m = cars[0].mil;
    if (cars[n - 1].mdl > m) m = cars[n - 1].mdl;

    for (int i = 0; i < n - 1; i++)
    {
        int s = cars[i].mdl + cars[i + 1].mil;
        if (s > m)
        {
            m = s;
        }
    }

    std::cout << m;

    delete [] cars;
}
