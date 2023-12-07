
// Submission ID: 12487764

#include <functional>
#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

int main()
{
    int n, k;
    std::cin >> n >> k;

    std::vector<std::pair<int, int>> activities (n);

    for (auto &[end, start] : activities)
    {
        std::cin >> start >> end;
    }

    std::sort(activities.begin(), activities.end());

    std::multiset<int, std::greater<>> rooms;
    while (k--) rooms.insert(0);

    int scheduled = 0;

    for (auto [end, start] : activities)
    {
        const auto room = rooms.upper_bound(start);

        if (room != rooms.end())
        {
            rooms.erase(room);
            rooms.insert(end);
            scheduled++;
        }
    }

    std::cout << scheduled;
}
