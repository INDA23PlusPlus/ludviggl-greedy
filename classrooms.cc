
// Submission ID: 12486019

#include <iostream>
#include <vector>
#include <algorithm>
#include <functional>

#define MAX 200_000

struct act { int start, stop; };

int main()
{
    int n, k;
    std::cin >> n >> k;


    std::vector<act> acts(n);

    for (int i = 0; i < n; i++)
    {
        std::cin >> acts[i].start >> acts[i].stop;
    }

    std::sort(
        acts.begin(),
        acts.end(),
        [] (const act &lhs, const act &rhs) {
            return lhs.stop == rhs.stop ?
                lhs.start < rhs.start :
                lhs.stop < rhs.stop;
        }
    );


    std::vector<int> rooms (k, 0);

    int scheduled = 0;

    for (auto act : acts)
    {
        auto room = std::upper_bound(rooms.begin(), rooms.end(), act.start, std::greater<int>());

        if (room != rooms.end())
        {
            *room = act.stop;
            scheduled++;

            auto insert = std::upper_bound(rooms.begin(), room, *room, std::greater<int>());
            std::rotate(insert, room, room + 1);
        }
    }


    std::cout << scheduled;
}
