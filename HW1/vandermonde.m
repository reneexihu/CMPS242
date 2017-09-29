## Copyright (C) 2017 Steven Reeves, UCSC, Applied Mathematics and Statistics
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

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} vandermonde (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Steven Reeves <sireeves@ucsc.edu>
## Created: 2017-09-29

function X = vandermonde (x_in, order)

## Calculate size of response variable
size = length(x_in); 

## Allocate Space for Vandermonde Matrix
X = ones(order+1, size);
X(2,:) = x_in;
## Create Matrix
for j = 1:size
  for i = 3:order+1
    X(i, j) = x_in(j)^(i-1);
  end
end

endfunction
