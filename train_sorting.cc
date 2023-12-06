// Submission ID: 12474067

#include <iostream>
#include <vector>
#include <algorithm>

struct car_t { int w, i, dl, il; };

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
    }

    int m = 0;

    for (int i = 0; i < n; i++)
    {
        int ll = 0, rl = 0;

        for (int l = 0; l < i; l++)
        {
            if (cars[l].dl > ll)
            {
                ll = cars[l].dl;
            }
        }

        for (int r = i; r < n; r++)
        {
            if (cars[r].il > rl)
            {
                rl = cars[r].il;
            }
        }

        if (ll + rl > m) m = ll + rl;
    }

    std::cout << m;

    delete [] cars;
}
