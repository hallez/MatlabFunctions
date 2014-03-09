function cols = set_var_col_const(vars)
% Set up column constants

nvar = length(vars);

cols = struct;
for ivar = 1:nvar
    cols.(vars{ivar}) = ivar;
end

end %function