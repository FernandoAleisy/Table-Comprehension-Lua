# Table-Comprehension-Lua
Function that allows to create a table in Lua in a simplified way, simulating the List comprehension method of Python or other programming languages.

-------------------------------------------------

To generate a table from another table:

        _{'f(i,v)', origin, extractio, 'g(i,v)'}

	
If the origin is a table, then, the table conprehension is equivalent to: 

        for i,v in extractio(origin) do
                if g(i,v) then
                        table.insert(tabla, f(i,v))
                end
        end

If g(i,v) is omitted, then, the table comprehension is equivalent to:

        for i,v extractio(origin) do
                table.insert(tabla, f(i,v))
        end

The extraction can be with pairs or ipairs, depending on whether you need the indices or the keys (i).
The function g(i,v) is the condition that i and/or v must fulfill. This argument can be omitted.

examples of f(i,v):

        'i*v'
        'i+2'
        'v^2'
        '"data "..i'
        'tonumber(v)'
        'v^2+3v-2'

Remember that, if the data source is a table, i will be each of the keys or indexes and v will be each of the values of the table.

examples of g(i,v):

        'i%2 == 0'
        'v == "oso"'
        'v%2 ~= 0'
        'tonumber(v)' --> If the value can be converted to a number

---------
Examples:

1° Create a table with the keys of a given table.

        tab = {a = 3,b = 5,c = 7,d = 9, 4, 5, 6, 7}
        t = _{'i', tab, 'pairs'}
        table.print(t)
		--> { 1, 2, 3, 4, c, b, a, d}

Although this can be achieved with the function table.keys

        t = table.keys(tab)
        table.print(t)
		--> { 1, 2, 3, 4, c, b, a, d}

2° Concatenate the even indexes with the word 'even index'.

	tab = {a = 3,b = 5,c = 7,d = 9, 4, 5, 6, 7}
	t_pares = _{'i.." indice par"', tab, 'ipairs', 'i%2==0'}
	table.print(t_pares)
		--> { 2 indice par, 4 indice par}

In this example:
	-- f(i,v) 		= 'i.." indice par"'
	-- origin		= la tabla tab
	-- extractio 	= iparis
	-- g(i,v) 		= 'i%2==0'


3° Concatenate the odd indices with the word 'odd index'.

        t2_impares = _{'i.." indice impar"', tab, 'ipairs', 'i%2~=0'}
        table.print(t2_impares)
		--> { 1 indice impar, 3 indice impar}

4° Create a table with the multiplies of 3 in a list

        lista = {2,6,8,12,14,18,21}
        mult_3 = _{'v', lista, 'pairs', 'v%3 == 0'}
        table.print(mult_3)
		--> { 6, 12, 18, 21}

----------------------------------------------------
To generate a table from a text string:

        _{'f(i)', origin, 'pattern', 'g(i)'}

If the source is a text, then table comprehension is equivalent to:

        for i in string.gmatch(origen, 'patrón') do
                if g(i) then
                        table.insert(tabla, f(i))
                end
        end

If g(i,v) is omitted, then, the table comprehension is equivalent to:

        for i in string.gmatch(origen, 'patrón') do
                table.insert(tabla, f(i))
        end

The patterns used in the string.gmatch() function must be taken into account.

Example:

        texto = 'var1, var2, var3,var4,var5,var6, var'
        t = _{'i',texto, '%d+','i%2==0'}
        table.print(t)
		--> { 2, 4, 6}

In this example the pattern '%d+' was used for the string.gmatch() function to return matches with digits. With g(i) = 'i%2==0' it was guaranteed that only even matches would be stored in the table.

--------------------------------------------------------------
To generate a table without a data source, with a sequence:

        s = _{'f(i)', seq,{inicio,final,saltos}, 'g(i)'}

This code is equivalent to:

        for i = start, end, jumps do
                if 'g(i)' then
                        table.insert(tabla, f(i))
                end
        end

If 'g(i)' is omitted, the code is equivalent to:

        for i = start, end, jumps do
                table.insert(tabla, f(i))
        end

Example:

        s = _{'math.floor (i^2)', seq,{2,20,2}, 'i%4==0'}
        table.print(s)
		--> { 16, 64, 144, 256, 400}
