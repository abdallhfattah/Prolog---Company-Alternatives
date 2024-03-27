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
