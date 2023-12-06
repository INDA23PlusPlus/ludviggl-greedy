
// Submission ID: 12471940

#include <iostream>
#include <unordered_map>
#include <algorithm>

#define MAX 20000

int main()
{
    int test_count;
    std::cin >> test_count;

    std::unordered_map<int, int> map, tmp;

    while (test_count--)
    {
        int price;
        int best = MAX;
        int value_count;
        std::cin >> price;
        std::cin >> value_count;

        map.clear();
        map[0] = 0;

        while (value_count--)
        {

            int value;
            std::cin >> value;

            tmp.clear();

            for (auto &[p, c] : map)
            {
                auto pv = p + value;

                if (pv <= best)
                {
                    if (pv >= price) best = pv;
                }
                else continue;

                tmp[pv] = c + 1;
            }

            for (auto &[p, c] : tmp)
            {
                auto pair = map.find(p);

                if (pair == map.end())
                {
                    map[p] = c;
                }
                else
                {
                    auto &v = map[p];
                    v = v > c ? c : v;
                }
            }
        }

        std::cout << best << ' ' << map[best] << '\n';
    }
}
