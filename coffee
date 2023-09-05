from menu import MENU
from menu import resources

is_on = True
profit = 0

def is_resource_ingredients(order_ingredients):
    '''to check that we have enough resource or not '''
    is_enough = True
    for item in order_ingredients:
        if order_ingredients[item] > resources[item]:
            print(f'we dont have enough {item}')
            #if that code run means we dont have enough
            is_enough = False
    return is_enough  # Return the result

def process_coin():
    '''calculated coin inserted'''
    total = 0
    print('please insert coins: ')
    total += int(input('how many quarters do you have: ')) * 0.25
    total += int(input('how many dimes do you have: ')) * 0.1
    total += int(input('how many nickels do you have: ')) * 0.05  # Corrected the value
    total += int(input('how many pennies do you have: ')) * 0.01
    return total

def is_transaction_successful(money_received, drink_cost):
    '''return true if user paid enough money'''
    global profit

    if money_received >= drink_cost:
        profit = profit + drink_cost
        change = round(money_received - drink_cost, 2)
        print(f'here is your change: {change}')
        return True
    else:
        print('sorry you didnt pay enough money')
        return False

# After each coffee this question will be displayed again
while is_on:
    choice = input('what do you want, espresso, latte, cappuccino: ')
    # a word to turn off the machine
    if choice == 'off':
        is_on = False
    elif choice == 'report':
        # to show how much we have in resources and profit
        for x in resources:
            print(f'{x}: {resources[x]}')
        print(f'profit: ${profit:.2f}')
    else:
        drink = MENU.get(choice)
        if drink:
            if is_resource_ingredients(drink['ingredients']):
                payment = process_coin()
                if is_transaction_successful(payment, drink['cost']):
                    resources_used = drink['ingredients']
                    for item in resources_used:
                        resources[item] -= resources_used[item]
        else:
            print('Invalid choice. Please select a valid drink.')
