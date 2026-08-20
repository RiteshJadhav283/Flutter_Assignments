import 'dart:io';

void main() {
	print('Choose a number from 1 to 5:');
	print('1. Check positive, negative, or zero');
	print('2. Check leap year');
	print('3. Find the smallest of three numbers');
	print('4. Print multiplication tables from 1 to 10');
	print('5. Calculate the sum of even numbers between 1 and 100');

	stdout.write('Enter your choice: ');
	int choice = int.parse(stdin.readLineSync()!);

	switch (choice) 
  {
//Q.1 Check whether a number is positive, negative, or zero.
		case 1:
			stdout.write('Enter a number: ');
			int number = int.parse(stdin.readLineSync()!);
			if (number > 0) {
				print('$number is positive');
			} else if (number < 0) {
				print('$number is negative');
			} else {
				print('$number is zero');
			}
			break;

//Q.2 Determine whether a year is a leap year.
		case 2:
			stdout.write('Enter a year: ');
			int year = int.parse(stdin.readLineSync()!);
			if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
				print('$year is a leap year');
			} else {
				print('$year is not a leap year');
			}
			break;

//Q.3 Find the smallest of three numbers.
		case 3:
			stdout.write('Enter first number: ');
			int first = int.parse(stdin.readLineSync()!);
			stdout.write('Enter second number: ');
			int second = int.parse(stdin.readLineSync()!);
			stdout.write('Enter third number: ');
			int third = int.parse(stdin.readLineSync()!);

			int smallest = first;
			if (second < smallest) {
				smallest = second;
			}
			if (third < smallest) {
				smallest = third;
			}
			print('Smallest number is: $smallest');
			break;

//Q.4 Print the multiplication tables from 1 to 10.
		case 4:
			for (int i = 1; i <= 10; i++) {
				print('Table of $i');
				for (int j = 1; j <= 10; j++) {
					print('$i x $j = ${i * j}');
				}
				print('');
			}
			break;

//Q.5 Calculate the sum of even numbers between 1 and 100.
		case 5:
			int sum = 0;
			for (int i = 2; i <= 100; i += 2) {
				sum += i;
			}
			print('Sum of even numbers between 1 and 100 is: $sum');
			break;
		default:
			print('Invalid choice');
	}
}
