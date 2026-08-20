import 'dart:io';

void main() {
	print('Choose a number from 1 to 5:');
	print('1. Print all prime numbers between 1 and 100');
	print('2. Reverse the digits of a number');
	print('3. Check whether a number is a palindrome');
	print('4. Check whether a number is an Armstrong number');
	print('5. Create a menu-driven calculator using switch');

	stdout.write('Enter your choice: ');
	int choice = int.parse(stdin.readLineSync()!);

	switch (choice) 
  {
  
//Q.1 Print all prime numbers between 1 and 100.
		case 1:
			for (int number = 2; number <= 100; number++) {
				bool isPrime = true;
				for (int i = 2; i * i <= number; i++) {
					if (number % i == 0) {
						isPrime = false;
						break;
					}
				}
				if (isPrime) {
					print(number);
				}
			}
			break;

//Q.2 Reverse the digits of a number.
		case 2:
			stdout.write('Enter a number: ');
			int number = int.parse(stdin.readLineSync()!);
			int reversed = 0;
			int temp = number;
			while (temp != 0) {
				reversed = reversed * 10 + temp % 10;
				temp ~/= 10;
			}
			print('Reverse of $number is $reversed');
			break;

//Q.3 Check whether a number is a palindrome.
		case 3:
			stdout.write('Enter a number: ');
			int number = int.parse(stdin.readLineSync()!);
			int reversed = 0;
			int temp = number;
			while (temp != 0) {
				reversed = reversed * 10 + temp % 10;
				temp ~/= 10;
			}
			if (number == reversed) {
				print('$number is a palindrome');
			} else {
				print('$number is not a palindrome');
			}
			break;
//Q.4 Check whether a number is an Armstrong number.
		case 4:
			stdout.write('Enter a number: ');
			int number = int.parse(stdin.readLineSync()!);
			int temp = number;
			int sum = 0;
			while (temp != 0) {
				int digit = temp % 10;
				sum += digit * digit * digit;
				temp ~/= 10;
			}
			if (sum == number) {
				print('$number is an Armstrong number');
			} else {
				print('$number is not an Armstrong number');
			}
			break;

//Q.5 Create a menu-driven calculator using switch.
		case 5:
			stdout.write('Enter first number: ');
			int a = int.parse(stdin.readLineSync()!);
			stdout.write('Enter second number: ');
			int b = int.parse(stdin.readLineSync()!);

			print('1. Addition');
			print('2. Subtraction');
			print('3. Multiplication');
			print('4. Division');
			stdout.write('Enter calculator choice: ');
			int operation = int.parse(stdin.readLineSync()!);

			switch (operation) {
				case 1:
					print('Sum = ${a + b}');
					break;
				case 2:
					print('Difference = ${a - b}');
					break;
				case 3:
					print('Product = ${a * b}');
					break;
				case 4:
					print('Quotient = ${a / b}');
					break;
				default:
					print('Invalid calculator choice');
			}
			break;
		default:
			print('Invalid choice');
	}
}
