function [] = fig_print( fig_handle, out_filename, varargin )
%FIG_PRINT Prints a figure to EPS format.
%   This function sets various figure properties and then prints
%   it to EPS format. The resulting EPS file can be imported into
%   a LaTeX document and will maintain it's properties.
%   Note that A4 size is 21.0 x 29.7 cm.

%% Input

% Defaults
DEFAULT_WIDTH = 15; % cm
DEFAULT_HEIGHT = 10; % cm
DEFAULT_FONT_SIZE = 10; % pt
DEFAULT_FONT = 'Times New Roman';
DEFAULT_AXES_LINE_WIDTH = 1.0; % pt

% Define input
p = inputParser;
p.addRequired('fig_handle', @ishandle);
p.addRequired('out_filename', @ischar);
p.addParameter('width', DEFAULT_WIDTH, @isscalar);
p.addParameter('height', DEFAULT_HEIGHT, @isscalar);
p.addParameter('font_size', DEFAULT_FONT_SIZE, @isscalar);
p.addParameter('font', DEFAULT_FONT, @ischar);
p.addParameter('axes_line_width', DEFAULT_AXES_LINE_WIDTH, @isscalar);

% Get input
p.parse(fig_handle, out_filename, varargin{:});
width = p.Results.width;
height = p.Results.height;
font_size = p.Results.font_size;
font = p.Results.font;
axes_line_width = p.Results.axes_line_width;

%% Update the figure and axes

% Get the figure's current on-screen position in cm
set(fig_handle, 'Units', 'centimeters');
position_cm = get(fig_handle, 'Position');
x0 = position_cm(1); y0 = position_cm(2);

% Set absolute dimentions for figure
set(fig_handle, ...
    'Position', [ x0, y0, width, height ], ...
	'PaperPositionMode', 'auto', ...
	'InvertHardCopy', 'on');

% Find all axis objects and set their properties
all_axes = findall(fig_handle, 'type', 'axes');
set(all_axes, ...
    'box','off', ...
    'FontUnits', 'points', ...
    'FontWeight', 'normal', ...
    'FontSize', font_size, ...
    'FontName', font, ...
    'LineWidth', axes_line_width);

% Print figure as EPS
print(fig_handle, out_filename, '-depsc2');

end

