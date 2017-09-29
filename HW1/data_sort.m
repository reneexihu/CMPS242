## Copyright (C) 2017 Steven Reeves
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Author: Steven Reeves <steven@steven-Lemur>
## Created: 2017-09-29

function [retval] = data_sort (input1, input2)

retval = zeros(length(input1), 2); 
[xtmp, i] = sort(input1); 

retval(:,1) = xtmp; 

for k = 1:length(input1)
  retval(k,2) = input2(i(k));  
end

endfunction
