:-consult(data).


%1. List all orders of a customer

list_orders(CustomerName, Orders) :-
    customer(CustomerId, CustomerName),
    list_orders_helper(CustomerId, Orders).

list_orders_helper(_, []).

list_orders_helper(CustomerId, [Order|Rest]) :-
    order(CustomerId, _, Order),
    list_orders_helper(CustomerId, Rest).

%2. Get number of orders of a customer

countOrdersOfCustomer(CustomerName, Count) :-
    customer(CustomerId, CustomerName),
    count_orders_helper(CustomerId, 1,Count).

count_orders_helper(_, Count, Count).
count_orders_helper(CustomerId, AccCount, Count) :-
    order(CustomerId, _, _),
    NewAccCount is AccCount + 1,
    order(NextCustomerId, _, _),
    NextCustomerId \= CustomerId, % Check if the next order belongs to a different customer
    !, % Cut to stop further backtracking
    Count = NewAccCount. % Stop counting, unify Count with the current count
count_orders_helper(CustomerId, AccCount, Count) :-
    order(CustomerId, _, _),
    NewAccCount is AccCount + 1,
    count_orders_helper(CustomerId, NewAccCount, Count).


%3.List all items in a specific customer order given cust id and order
%id

getItemsInOrderById(CustomerName, OrderId, Items) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderId, Items).




lengthOfList(List, Count) :-
    lengthOfList(List, 0, Count).

lengthOfList([], Acc, Acc).
lengthOfList([_|L], Acc, Length) :-
    NewAcc is Acc + 1,
    lengthOfList(L, NewAcc, Length).


getNumOfItems(CustomerName, OrderID, Count) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    lengthOfList(Items, Count).


isBoycott(X) :-
    boycott_company(X , _).

isBoycott(Item) :-
    item(Item, Company, _),
    boycott_company(Company, _).

whyToBoycott(CompanyName, Justification) :-
    boycott_company(CompanyName, Justification).

whyToBoycott(Item, Justification):-
    item(Item, Company, _),
    boycott_company(Company, Justification).

removeBoycottItemsFromAnOrder(Username, OrderID, NewList):-
    customer(CustomerID, Username),
    order(CustomerID, OrderID, Items),
    removeBoycottItems(Items, NewList).

removeBoycottItems([], []).
removeBoycottItems([Item|Rest], NewList):-
    isBoycott(Item),
    removeBoycottItems(Rest, NewList).
removeBoycottItems([Item|Rest], [Item|NewList]) :-
    removeBoycottItems(Rest, NewList).

alternativeItem(Item, AltItem) :-
    alternative(Item, AltItem).

% Predicate to replace boycotted items in an order
replaceBoycottItemsFromAnOrder(Username, OrderID, NewList) :-
    customer(CustomerID, Username),
    order(CustomerID, OrderID, Items),
    replaceBoycottItems(Items, NewList).

replaceBoycottItems([], []).
replaceBoycottItems([Item|Rest], [NewItem|NewRest]) :-
    (   isBoycott(Item),
        alternativeItem(Item, AltItem)
    ->  NewItem = AltItem
    ;    NewItem = Item
    ),
    replaceBoycottItems(Rest, NewRest).


getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alternative, DiffPrice) :-
    item(Item, _, Price1),
    alternative(Item, Alternative),
    item(Alternative, _, Price2),
    DiffPrice is Price1 - Price2.

calcPriceAfterReplacingBoycottItemsFromAnOrder(Username, OrderID, NewList, TotalPrice) :-
    order(CustomerID, OrderID, Items),
    customer(CustomerID, Username),
    replaceBoycottItems(Items, NewList),
    calculateTotalPrice(NewList, TotalPrice).

replaceBoycottItems([], []).
replaceBoycottItems([Item|Rest], [NewItem|NewRest]) :-
    (   alternative(Item, NewItem)
    ;   item(Item, Company, _) , boycott_company(Company, _) , alternative(Item, NewItem) % If the item is boycotted
    ;   NewItem = Item
    ),
    replaceBoycottItems(Rest, NewRest).

calculateTotalPrice([], 0).

calculateTotalPrice([Item|Items], TotalPrice) :-
    item(Item, _, Price),
    calculateTotalPrice(Items, RestPrice),
    TotalPrice is Price + RestPrice.

calcPriceOfOrder(CustomerName, OrderID, TotalPrice) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    calculateTotalPrice(Items, TotalPrice).

getTheDifferenceInPriceBetweenItemAndAlternative(Item, Alternative, DiffPrice) :-
    item(Item, _, Price1),
    alternative(Item, Alternative),
    item(Alternative, _, Price2),
    DiffPrice is Price1 - Price2.

add_item(ItemName, CompanyName, Price) :-
    assert(item(ItemName, CompanyName, Price)).

remove_item(ItemName, CompanyName, Price) :-
    retract(item(ItemName, CompanyName, Price)).

add_alternative(ItemName, AlternativeItem) :-
    assert(alternative(ItemName, AlternativeItem)).

remove_alternative(ItemName, AlternativeItem) :-
    retract(alternative(ItemName, AlternativeItem)).

add_boycott_company(CompanyName, Justification) :-
    assert(boycott_company(CompanyName, Justification)).

remove_boycott_company(CompanyName, Justification) :-
    retract(boycott_company(CompanyName, Justification)).
