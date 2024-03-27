:-consult(data).

getNumOfItems(CustomerName, OrderID, Count) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    length(Items, Count).

isBoycott(X) :-
    boycott_company(X , _).

isBoycott(Item) :-
    item(Item, Company, _),
    boycott_company(Company, _).

calculateTotalPrice([Item|Rest], TotalPrice) :-
    item(Item, _, Price),
    calculateTotalPrice(Rest, RestPrice),
    TotalPrice is Price + RestPrice.

calcPriceOfOrder(CustomerName, OrderID, TotalPrice) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    calculateTotalPrice(Items, TotalPrice).

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
