%% ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                                INSTRUCTIONS
%__________________________________________________________________________
%
% It generates and (potentially) saves all the figures in the desired format.
%
saving_flag     = 0;                                                    % if '1', images (i.e., plots) are saved (as .png files);
                                                                        % otherwise, they ain't saved
title_flag      = 1;                                                    % if '1', titles are added to images;
                                                                        % otherwise, they ain't added
threeDplot_flag = 1;
%
image_extension = 'pdf';                                                % pdf, png, ...
images_path     = '/Users/v/Documents/MATLAB/Tavole/Tavola_1a/images';  % It is the folder where images will be saved.
                                                                        % *** !!! change this path if needed !!! ***
main_path       = '/Users/v/Documents/MATLAB/Tavole/Tavola_1a';         % It is the folder containing the source code.
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
%%_________________________________________________________________________

n = p560.n;                                          % #Links
if ((m_subplot * n_subplot) / n ~= 1)   % n is the number of links
    error("(m_subplot * n_subplot) / n != 1  :-(")
end

if (saving_flag == 1)
    cd(images_path)
end




%% Plot traiettoria giunti
if (strcmpi(controller, 'PD') || strcmpi(controller, 'CT') || strcmpi(controller, 'BS'))

    figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

    for i = 1 : n
        subplot(m_subplot, n_subplot, i)
        ax = gca;
        ax.XAxis.FontSize = font_size_numbers_of_axes;
        ax.YAxis.FontSize = font_size_numbers_of_axes;
        set(gca,'TickLabelInterpreter', 'latex')
        hold on
        grid on
        eval(['plot(out.q.time, out.q.signals.values(:,' num2str(i) '),''b'',''LineWidth'', plot_LineWidth)'])
        eval(['plot(time, q_des(:,' num2str(i) '),''r--'',''LineWidth'', plot_LineWidth)'])
        xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
        ylabel(sprintf('Joint %d [rad]',i), 'Interpreter','latex', 'FontSize', font_size_XYlabel)
%         legend(sprintf('$\\widehat{q}_%d$',i), sprintf('$q_%d$',i), 'Interpreter','latex', 'FontSize', font_size_legend)
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
end



%% Plot errore ai giunti
if (strcmpi(controller, 'PD') || strcmpi(controller, 'CT') || strcmpi(controller, 'BS'))

    figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on

    Legend = cell(n,1);
    for i = 1 : n
        eval(['plot(out.e_pos.time, out.e_pos.signals.values(:,' num2str(i) '),''LineWidth'', plot_LineWidth)'])
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
end



%% End effector
if (strcmpi(controller, 'PD') || strcmpi(controller, 'CT') || strcmpi(controller, 'BS'))
    % Cinematica diretta
    tmp_T = p560.fkine(out.q.signals.values);
    % Traslazione EE
    tmp_p = transl(tmp_T);
    % RPY E.E
    tmp_r = tr2rpy(tmp_T);
elseif (strcmpi(controller, 'Kinematic_grad') || strcmpi(controller, 'Kinematic_LevMar'))
    tmp_p = out.ee_pos.signals.values;
    tmp_r(:,1) = out.ee_or.signals.values(:,3);
    tmp_r(:,2) = out.ee_or.signals.values(:,2);
    tmp_r(:,3) = out.ee_or.signals.values(:,1);
end

figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

% EE translation
subplot(2,2,1)
ax = gca;
ax.XAxis.FontSize = font_size_numbers_of_axes;
ax.YAxis.FontSize = font_size_numbers_of_axes;
set(gca,'TickLabelInterpreter', 'latex')
hold on
grid on
plot(out.q.time, tmp_p(:,1), 'Color', [0,102,255]/255, 'LineWidth', plot_LineWidth)
plot(out.q.time, tmp_p(:,2), 'Color', [0, 153, 0]/255, 'LineWidth', plot_LineWidth)
plot(out.q.time, tmp_p(:,3), 'Color', [255, 102, 0]/255, 'LineWidth', plot_LineWidth)
xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
ylabel('Spatial coordinates [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
legend('x', 'y', 'z', 'Interpreter','latex', 'FontSize', font_size_legend)
title('EE translation', 'fontweight', 'bold', 'Interpreter','latex', 'FontSize', font_size_title)

% EE orientation
subplot(2,2,2)
ax = gca;
ax.XAxis.FontSize = font_size_numbers_of_axes;
ax.YAxis.FontSize = font_size_numbers_of_axes;
set(gca,'TickLabelInterpreter', 'latex')
hold on
grid on
plot(out.q.time, tmp_r(:,1), 'Color', [0,102,255]/255, 'LineWidth', plot_LineWidth)
plot(out.q.time, tmp_r(:,2), 'Color', [0, 153, 0]/255, 'LineWidth', plot_LineWidth)
plot(out.q.time, tmp_r(:,3), 'Color', [255, 102, 0]/255, 'LineWidth', plot_LineWidth)
xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
ylabel('RPY angles [rad]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
legend('Roll', 'Pitch', 'Yaw', 'Interpreter','latex', 'FontSize', font_size_legend)
title('EE orientation', 'fontweight', 'bold', 'Interpreter','latex', 'FontSize', font_size_title)

% Plot piano XY
subplot(2,2,3)
ax = gca;
ax.XAxis.FontSize = font_size_numbers_of_axes;
ax.YAxis.FontSize = font_size_numbers_of_axes;
set(gca,'TickLabelInterpreter', 'latex')
hold on
grid on
plot(tmp_p(:,1), tmp_p(:,2), 'b','LineWidth', plot_LineWidth)
xlabel('$x$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
ylabel('$y$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
title('XY view', 'fontweight', 'bold', 'Interpreter','latex', 'FontSize', font_size_title)
axis equal

% Plot 3d
subplot(2,2,4)
ax = gca;
ax.XAxis.FontSize = font_size_numbers_of_axes;
ax.YAxis.FontSize = font_size_numbers_of_axes;
set(gca,'TickLabelInterpreter', 'latex')
hold on
grid on
plot3(tmp_p(:,1), tmp_p(:,2), tmp_p(:,3), 'b', 'LineWidth',  plot_LineWidth)
xlabel('$x$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
ylabel('$y$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
zlabel('$z$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
title('3D view', 'fontweight', 'bold', 'Interpreter','latex', 'FontSize', font_size_title)
view(ax,[10 25]);

if (saving_flag == 1)
    exportgraphics(gcf, [controller, sprintf('__'), task, '__EE translation - orientation - XY view - 3D view.', image_extension], 'BackgroundColor', 'white')      % crop + white background
end













%% Plot errore end-effector
if (strcmpi(controller, 'Kinematic_grad') || strcmpi(controller, 'Kinematic_LevMar'))

    figure('Renderer', 'painters', 'Position', [10 800 1000 564]);

    % Translation Error
    subplot(2,1,1)
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on
    plot(out.err_ee.time, out.err_ee.signals.values(:,4:6),'LineWidth', plot_LineWidth)
    xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel('Translation Error [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    legend('$e_1=\xi_{d,1}-\xi_1$','$e_1=\xi_{d,2}-\xi_2$','$e_3=\xi_{d,3}-\xi_3$', 'Interpreter','latex', 'FontSize', font_size_legend)

    % Rotation Error
    subplot(2,1,2)
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on
    plot(out.err_ee.time, out.err_ee.signals.values(:,1:3),'LineWidth', plot_LineWidth)
    xlabel('$t$ [s]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel('Rotation Error [rad]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    legend('$e_4=\xi_{d,4}-\xi_4$','$e_5=\xi_{d,5}-\xi_5$','$e_6=\xi_{d,6}-\xi_6$', 'Interpreter','latex', 'FontSize', font_size_legend)

    if (title_flag == 1)
        % TITLE
        ax = axes;
        t1 = title('\textbf{End-effector error}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
        ax.Visible = 'off';
        t1.Visible = 'on';
    end
    if (saving_flag == 1)
        string_fileName = [controller, sprintf('__'), task, '__ee_error.', image_extension];
        exportgraphics(gcf, string_fileName, 'BackgroundColor', 'white')
    end
end




%% Visualizzo traiettoria end-effector
if (threeDplot_flag == 1)
    f = figure('Renderer', 'painters', 'Position', [10 800 1000 564]);
    ax = gca;
    ax.XAxis.FontSize = font_size_numbers_of_axes;
    ax.YAxis.FontSize = font_size_numbers_of_axes;
    set(gca,'TickLabelInterpreter', 'latex')
    hold on
    grid on

    plotvol([-1,1,-1,1,-1,1])
    p560.plot(out.q.signals.values, 'trail',{'r','LineWidth', 1})
    xlabel('$x$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    ylabel('$y$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)
    zlabel('$z$ [m]', 'Interpreter','latex', 'FontSize', font_size_XYlabel)

    if (title_flag == 1)
        % TITLE
        ax = axes;
        t1 = title('\textbf{End-effector trajectory}', 'FontSize', font_size_title, 'Interpreter', 'Latex');
        ax.Visible = 'off';
        t1.Visible = 'on';
    end
    if (saving_flag == 1)
        exportgraphics(gcf, [controller, sprintf('__'), task, '__End-effector_trajectory.', image_extension], 'BackgroundColor', 'white')
    end
end



if (saving_flag == 1)
    cd(main_path)
end
