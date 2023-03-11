close all

t_max_index = find(out.pi_est.time == out.pi_est.time(end));

%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                                INSTRUCTIONS
%__________________________________________________________________________
%
% It generates and (potentially) saves all the figures in the desired format.
%
saving_flag     = 0;                                                                % if '1', images (i.e., plots) are saved (as .png files);
                                                                                    % otherwise, they ain't saved
title_flag      = 1;                                                                % if '1', titles are added to images;
                                                                                    % otherwise, they ain't added
threeDplot_flag = 1;                                                                % if '1', plots robot's trajectory in 3D space
%
image_extension = 'pdf';                                                            % pdf, png, ...
images_path     = '/Users/username/Documents/MATLAB/puma560-control/img_adaptive/'; % It is the folder where images will be saved.
                                                                                    % *** !!! change this path if needed !!! ***
main_path       = '/Users/username/Documents/MATLAB/puma560-control/src_adaptive/'; % It is the folder containing the source code.
                                                                                    % *** !!! change this path if needed !!! ***
%%_________________________________________________________________________



%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                            Graphics Parameters
%%_________________________________________________________________________
scaleFactor                 = 0.8;                  % font-scaling multiplicative factor
font_size_title             = 22 * scaleFactor;
font_size_XYlabel           = 22 * scaleFactor;
font_size_numbers_of_axes   = 13 * scaleFactor;
font_size_legend            = 14 * scaleFactor;
font_size_addedText         = 14 * scaleFactor;
plot_LineWidth              = 0.5;
m_subplot                   = 3;                    % number of rows composing a "subplot-type" plot
n_subplot                   = 2;                    % number of columns composing a "subplot-type" plot
n                           = p560.n;               % #Links
%%_________________________________________________________________________

if ((m_subplot * n_subplot) / n ~= 1)   % n is the number of links
    error("(m_subplot * n_subplot) / n != 1  :-(")
end

if (saving_flag == 1)
    cd(images_path)
end




%% Plot estimated masses
figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

for i = 1 : n       % i-th Link
    subplot(m_subplot, n_subplot, i)
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on

    plot(out.pi_est.time(1:t_max_index), out.pi_est.signals.values(1:t_max_index,i*10),'b', 'LineWidth', plot_LineWidth);
    plot(out.pi_est.time(1:t_max_index), pi_real(i*10) * ones(t_max_index,1),'r--', 'LineWidth', plot_LineWidth);

    xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel(sprintf('Mass %d [kg]',i), 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    legend(sprintf('$\\widehat{m}_%d$',i), sprintf('$m_%d$',i), 'Interpreter','latex', 'FontSize', font_size_legend)
end

if (title_flag == 1)
    ax = axes;
    t1 = title('\textbf{Mass Estimation}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
    ax.Visible = 'off';
    t1.Visible = 'on';
end
if (saving_flag == 1)
    exportgraphics(gcf, [controller, sprintf('__'), task, '__Mass_estimation.', image_extension], 'BackgroundColor', 'white')
end





%% Plot joint trajectories
figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

for i = 1 : n       % i-th Link
    subplot(m_subplot, n_subplot, i)
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on

    plot(out.q.time(1:t_max_index), out.q.signals.values(1:t_max_index,i),'b', 'LineWidth', plot_LineWidth);
    plot(time, q_des(:,i),'r--', 'LineWidth', plot_LineWidth);

    xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel(sprintf('Joint %d [rad]',i), 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    legend(sprintf('$q_%d$',i), sprintf('$q_{%d,d}$',i), 'Interpreter','latex', 'FontSize', font_size_legend)
end

if (title_flag == 1)
    ax = axes;
    t1 = title('\textbf{Joint trajectories}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
    ax.Visible = 'off';
    t1.Visible = 'on';
end
if (saving_flag == 1)
    exportgraphics(gcf, [controller, sprintf('__'), task, '__Joint_trajectories.', image_extension], 'BackgroundColor', 'white')
end




%% Plot joint errors
figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

ax = gca;
ax.XAxis.FontSize = font_size_numbers_of_axes;
ax.YAxis.FontSize = font_size_numbers_of_axes;
set(gca,'TickLabelInterpreter', 'latex')
hold on
grid on

Legend = cell(n,1);
for i = 1 : n
    plot(out.err_q.time(1:t_max_index), out.err_q.signals.values(1:t_max_index,i), 'LineWidth', plot_LineWidth);
    Legend{i} = sprintf('$e_%d$',i);
end
legend(Legend, 'Interpreter','latex', 'FontSize', font_size_legend)

xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
ylabel('e [rad]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)

if (title_flag == 1)
    ax = axes;
    t1 = title('\textbf{Joint errors}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
    ax.Visible = 'off';
    t1.Visible = 'on';
end
if (saving_flag == 1)
    exportgraphics(gcf, [controller, sprintf('__'), task, '__Joint_errors.', image_extension], 'BackgroundColor', 'white')
end




%% Plot the robot's trajectory in 3D space
if (threeDplot_flag == 1)
    f = figure('Renderer', 'painters', 'Position', [10 800 1000 564]);
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on

    plotvol([-1,1,-1,1,-1,1])
    p560.plot(out.q.signals.values, 'trail',{'r','LineWidth', 1});

    xlabel('$x$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel('$y$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    zlabel('$z$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)

    if (title_flag == 1)
        ax = axes;
        t1 = title('\textbf{End-effector trajectory}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
        ax.Visible = 'off';
        t1.Visible = 'on';
    end
    if (saving_flag == 1)
        exportgraphics(gcf, [controller, sprintf('__'), task, '__End-effector_trajectory.', image_extension], 'BackgroundColor', 'white')
    end
end


%%
if (saving_flag == 1)
    cd(main_path)
end
