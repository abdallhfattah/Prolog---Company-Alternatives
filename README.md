# Artificial Intelligence Course - Assignment 1

## Problem Statement

In this assignment, you are required to write a Prolog program that manages customer orders and provides information on boycotted items and their alternatives. The program should answer questions about customers and their orders and assist customers in finding alternative products to boycotted items.

## Facts (data.pl file)

You must use the provided `data.pl` file, which contains facts about customers, items, orders, boycotted companies, and their alternatives. For example:

```prolog
customer(CustID, CustUserName).
item(ItemName, CompanyName, Price).
order(CustID, OrderID, [Items]).
boycott_company(CompanyName, Justification).
alternative(ItemName, AlternativeItem).
```
## Required Predicates

1. **List all orders of a specific customer:** `list_orders(CustomerUserName, OrdersList)`
2. **Get the number of orders of a specific customer:** `count_orders(CustomerUserName, Count)`
3. **List all items in a specific customer order:** `get_items_in_order(CustomerUserName, OrderID, ItemsList)`
4. **Get the number of items in a specific customer order:** `get_num_of_items(CustomerUserName, OrderID, Count)`
5. **Calculate the price of a given order:** `calc_price_of_order(CustomerUserName, OrderID, TotalPrice)`
6. **Check if an item or company needs to be boycotted:** `is_boycott(ItemOrCompanyName)`
7. **Get the justification for boycotting an item or company:** `why_to_boycott(ItemOrCompanyName, Justification)`
8. **Remove all boycotted items from an order:** `remove_boycott_items(CustomerUserName, OrderID, NewList)`
9. **Update an order by replacing all boycotted items with alternatives:** `replace_boycott_items(CustomerUserName, OrderID, NewList)`
10. **Calculate the price of an order after replacing boycotted items:** `calc_price_after_replacing_boycott_items(CustomerUserName, OrderID, NewList, TotalPrice)`
11. **Calculate the price difference between an item and its alternative:** `get_difference_in_price(ItemName, AlternativeItem, DiffPrice)`
12. **Bonus: Insert/remove item, alternative, or new boycott company:** `add_item(ItemName, CompanyName, Price)`, `remove_item(ItemName, CompanyName, Price)`, `add_boycott_company(CompanyName, Justification)`, `remove_boycott_company(CompanyName, Justification)`

Please refer to the assignment instructions for detailed explanations and examples of each predicate.
