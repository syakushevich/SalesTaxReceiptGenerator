# InputParser Module

This module parses shopping basket input files. It reads lines formatted as 
"<quantity> <product description> at <price>" and returns a hash with the original 
product name (preserving "imported"), its normalized version for tax lookup, quantity, 
price, and tax type.

# TaxCalculator Class

This class calculates sales taxes for shopping basket items using defined tax rates.
It provides methods to round tax amounts to the nearest 0.05, compute the total sales tax for a collection of items,
and determine the final price for an individual item (including tax). It implements the strategy pattern,
which allows for swapping in alternative tax calculation strategies if needed. This decoupling improves testability
and flexibility.

# OutputGenerator Class

This class generates a receipt for shopping basket items by combining tax calculations with item data.
It formats each item's final price (including tax), computes the overall sales taxes and total price,
and provides a method to print the receipt.
