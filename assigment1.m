% Author: Klara Martinaskova
% AI in Healthcare 2023
% MATLAB Assignments 1

% Steps
% 1) Upload data to Matlab
% 2) Define theta0, theta1, and alpha - give them random values at first
% 3) Create for loop for gradient decent - the values of hypothesis, theta0, and theta1 should change in every for loop iteration. Also, calculate the cost for checking. The number of iterations can also be chosen freely.
% 4) As a result, you should have the values of theta0 and theta1.
% 5) Plot the cost for every for loop iteration and make sure the gradient descent converges.
% 6) Draw the line h = theta0 + theta1 * x. To draw the line, you can use freely chosen values of x and calculate the corresponding values of h.
% 7) Calculate the estimated birth weight when the gestational age is 34 weeks.

close all
clear all
clc
%% 1) Upload data to Matlab
data = load('ex1_data.mat'); 

g_age = data.GestationalAge; % gestational age
b_weight = data.BirthWeight; % birth weight

%% 2) Define theta0, theta1, and alpha - give them random values at first
theta0 = rand()- 0.5;   % random value between -0.5 and 0.5
theta1 = rand()- 0.5;   % random value between -0.5 and 0.5
alpha = 0.001;          % learning rate
%% Gradient descent 
%   3) Create for loop for gradient descent. 
%       The values of hypothesis, theta0, and theta1 should change in every for loop iteration. 
%       Also, calculate the cost for checking. The number of iterations can also be chosen freely.
%   4) As a result, you should have the values of theta0 and theta1.
%   5) Plot the cost for every for loop iteration and make sure the gradient descent converges.

iter_num = 25; % define number of iterations (for this data set)
% I tried also 10, 50, 100, 500, 1000 iterations,
% but 25 iterations is for this dataset enough. 

x = g_age; % set gestational age as variable x
y = b_weight; % set birth weight as variable y
m = length(g_age); % m = the number of training examples

J_memory= zeros(iter_num, 1);% helper variable for saving all J during iterations

figure(1)
hold on;
plot(x, y, 'o');
xlabel('Gestational age [weeks]')
ylabel('Birth weight [g]')
title('Predicted linear regression over iterations')

for i = 1:iter_num
    
    % Calculate hypothesis
    h = theta0 + theta1*x; % linear regression - predicted values
   
    % Plot line to figure 'Predicted linear regression over iterations'
    plot(x, h);
    pause(0.1);
    
    % Calculate gradients
    grad0 = (1/m)*sum(h-y); 
    grad1 = (1/m)*sum((h-y).*x);

    % Calculate cost function
    J = (1/(2*m))*sum((h-y).^2);
    J_memory(i) = J;  % add current J to memory of J

    % Update theta0 and theta1
    if i ~= iter_num % for last iteration is not necessary updating
        theta0 = theta0 - alpha*grad0;
        theta1 = theta1 - alpha*grad1; 
    end
   
end

% Plot cost function
figure(2)
plot(J_memory, 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost');
title('Cost function over iterations');

%% 6) Draw the line 
% h = theta0 + theta1 * x -(but I use the last h from gradient descent, which is the same). 
% To draw the line, you can use freely chosen values of x and calculate the corresponding values of h.

figure(3)
hold on
plot(x, y, 'o'); % plot training data
plot(x, h) % plot linear fit to the data (using last h for last theta0 and theta1)
xlabel('Gestational age [weeks]')
ylabel('Birth weight [g]')
title('Prediction of Birth Weight')

%% 7) Calculate the estimated birth weight when the gestational age is 34 weeks.
% theta0 and theta 1 - choose the last updating from gradient descent

week = 34;
b_weight_estim = theta0 + theta1 * week; % h = theta0 + theta1 * x 

% Printing results:
fprintf('The estimated birth weight for the gestational age %d weeks is: %.2f g.\n', week, b_weight_estim);

