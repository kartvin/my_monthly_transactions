# my_monthly_transactions
Loads and displays a user's transactions. 
Determines how much money the user spends and makes in each of the months

Compatible Versions:
iOS 9.0 and above

Combatible Devices:
iPhone and iPad

Codebase:
Swift

Implemented following:
The user is so enthusiastic about donuts that they don't want donut spending to come out of their budget. Disregard all donut-related transactions from the spending. You can just use the merchant field to determine what's a donut - donut transactions will be named “Krispy Kreme Donuts” or “DUNKIN #336784”.
- We expose a GetProjectedTransactionsForMonth endpoint, which returns all the transactions that have happened or are expected to happen for a given month. It looks like right now it only works for this month, but that's OK. Merge the results of this API call with the full list from GetAllTransactions and use it to generate predicted spending and income numbers for the rest of this month, in addition to previous months.
- Paying off a credit card shows up as a credit transaction and a debit transaction, but it's not really "spending" or "income". Make your aggregate numbers disregard credit card payments. For the users we give you, credit card payments will consist of two transactions with opposite amounts (e.g. 5000000 centocents and -5000000 centocents) within 24 hours of each other.
