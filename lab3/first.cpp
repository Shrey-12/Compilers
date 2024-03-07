#include <iostream>
#include <string.h>
#include <fstream>
#define max 20

using namespace std;

char productions[max][10];
char Terminals[10], nonTerminals[10];
char first[10][10], follow[10][10];
int eps[10];
int count = 0;

//find position in production
int findpos(char ch)
{
    int n;
    for (n = 0; nonTerminals[n] != '\0'; n++)
        if (nonTerminals[n] == ch)
            break;
    if (nonTerminals[n] == '\0')
        return 1;
    return n;
}

int IsCap(char c)
{
    if (c >= 'A' && c <= 'Z')
        return 1;
    return 0;
}
//if not already present in array add
void add(char *arr, char c)
{
    int i, flag = 0;
    for (i = 0; arr[i] != '\0'; i++)
    {
        if (arr[i] == c)
        {
            flag = 1;
            break;
        }
    }
    if (flag != 1)
        arr[strlen(arr)] = c;
}

// adding s2 to s1, excluding whats already present
void addarr(char *s1, char *s2)
{
    for (int i = 0; s2[i] != '\0'; i++)
    {
        int flag = 0;
        int j = 0;
        while(true)
        {
            if (s2[i] == s1[j])
            {
                flag = 1;
                break;
            }
            if (j == strlen(s1) && flag != 1)
            {
                s1[strlen(s1)] = s2[i];
                break;
            }
            j++;
        }
    }
}

// to add production to productions array
void addprod(char *s)
{
    int i;
    productions[count][0] = s[0];
    for (i = 3; s[i] != '\0'; i++)
    {
        if (!IsCap(s[i]))
            add(Terminals, s[i]);
        productions[count][i - 2] = s[i];
    }
    productions[count][i - 2] = '\0';
    add(nonTerminals, s[0]);
    count++;
}

void findfirst()
{
    int e;
    //looping through productions
    for (int i = 0; i < count; i++)
    {
        // iterate over each production again
        for (int j = 0; j < count; j++)
        {
            int n = findpos(productions[j][0]);
            if (productions[j][1] == '#')
                eps[n] = 1;
            else
            {
                // process each symbol in production
                for (int k = 1, e = 1; productions[j][k] != '\0' && e == 1; k++)
                {
                    //if symbol is terminal add it to first
                    if (!IsCap(productions[j][k]))
                    {
                        e = 0;
                        add(first[n], productions[j][k]);
                    }
                    else
                    {
                        int n1 = findpos(productions[j][k]);
                        addarr(first[n], first[n1]);
                        // if eps flag is not set for non terminal set e to 0
                        if (eps[n1] == 0)
                            e = 0;
                    }
                }
                if (e == 1)
                    eps[n] = 1;
            }
        }
    }
}

void findfollow()
{
    int i, j, k, n, e, n1;
    //find position of starting non terminal and add $ to its follow 
    n = findpos(productions[0][0]);
    add(follow[n], '$');
    for (i = 0; i < count; i++)
    {
        for (j = 0; j < count; j++)
        {
            // initialize k to index of last symbol
            k = strlen(productions[j]) - 1;
            // iterate through each symbol in reverse order
            for (; k > 0; k--)
            {
                if (IsCap(productions[j][k]))
                {
                    n = findpos(productions[j][k]);
                    // if next symbol is end of production, add follow of left non Terminal
                    if (productions[j][k + 1] == '\0')
                    {
                        n1 = findpos(productions[j][0]);
                        addarr(follow[n], follow[n1]);
                    }
                    // if next symbol is non Terminal add first of next in currents follow
                    if (IsCap(productions[j][k + 1]))
                    {
                        n1 = findpos(productions[j][k + 1]);
                        addarr(follow[n], first[n1]);
                        // if next non Terminal derives eps, add follow of LHS non terminal
                        if (eps[n1] == 1)
                        {
                            n1 = findpos(productions[j][0]);
                            addarr(follow[n], follow[n1]);
                        }
                    }
                    else if (productions[j][k + 1] != '\0')
                        add(follow[n], productions[j][k + 1]);
                }
            }
        }
    }
}

int main()
{
    char s[max], i;
    ifstream inputFile("input.txt");
    while (inputFile >> s)
    {
        addprod(s);
    }
    inputFile.close();

    findfirst();
    findfollow();
    for (i = 0; i < strlen(nonTerminals); i++)
    {
        cout << nonTerminals[i] << "\t";
        cout << first[i];
        if (eps[i] == 1)
            cout << '#' << "\t";
        else
            cout << "\t";
        cout << follow[i] << endl;
    }
    return 0;
}
