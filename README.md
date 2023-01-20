# Table-Comprehension-Lua
Función que permite usar crear una tabla en Lua de forma simplificada, simulando el método List comprehension de Python o de otros lenguajes de programación

-------------------------------------------------

Para generar una tabla a partir de otra tabla:

        _{'f(i,v)', origen, extraccion, 'g(i,v)'}

	
-- Si el origen es una tabla, la table conprehension 
-- equivale 

        for i,v in extraccion(orgen) do
                if condicion(i,v) then
                        table.insert(tabla, f(i,v))
                end
        end

-- Si se omite g(i,v), entonces la table comprehension 
-- equivale a:

        for i,v extraccion(orgen) do
                table.insert(tabla, f(i,v))
        end

-- la extracción pueder ser con pairs o ipairs, según si
-- necesitas los indices o los keys (i)

-- la función g(i,v) es la condición que deben cumplir
-- i y/o v. Este argumento se puede omitir

-- ejemplos de f(i,v):

        'i*v'
        'i+2'
        'v^2'
        '"dato "..i'
        'tonumber(v)'
        'v^2+3v-2'

-- Recordar que si el origen de los datos es una tabla
-- i sera cada una de las keys o indices y v será cada
-- uno de los values de la tabla

-- ejemplos de g(i,v):

        'i%2 == 0'
        'v == "oso"'
        'v%2 ~= 0'
        'tonumber(v)' --> Si el value se puede convertir a número


-- Ejemplos:

-- Crear una tabla con las keys de una tabla dada

        tab = {a = 3,b = 5,c = 7,d = 9, 4, 5, 6, 7}
        t = _{'i', tab, 'pairs'}
        table.print(t)
		--> { 1, 2, 3, 4, c, b, a, d}

-- Aunque esto se puede lograr con la función table.keys

        t = table.keys(tab)
        table.print(t)
		--> { 1, 2, 3, 4, c, b, a, d}

-- Concatenar los indices pares  con  la  palabra
-- 'indice par'

tab = {a = 3,b = 5,c = 7,d = 9, 4, 5, 6, 7}

t_pares = _{'i.." indice par"', tab, 'ipairs', 'i%2==0'}
table.print(t_pares)
		--> { 2 indice par, 4 indice par}

	-- En este ejemplo:
	-- f(i,v) 		= 'i.." indice par"'
	-- origen 		= la tabla tab
	-- extracción 	= iparis
	-- g(i,v) 		= 'i%2==0'


-- Concatenar los indices impares con la palabra
-- 'indice impar'

        t2_impares = _{'i.." indice impar"', tab, 'ipairs', 'i%2~=0'}
        table.print(t2_impares)
		--> { 1 indice impar, 3 indice impar}


-- Crear una tabla con los multiplos de 3 de una
-- lista

        lista = {2,6,8,12,14,18,21}
        mult_3 = _{'v', lista, 'pairs', 'v%3 == 0'}
        table.print(mult_3)
		--> { 6, 12, 18, 21}

-- Para generar una tabla a partir una cadena de texto:

        _{'f(i)', origen, 'patrón', 'g(i)'}

-- Si el origen es una tabla, la table conprehension 
-- equivale a:

        for i in string.gmatch(origen, 'patrón') do
                if g(i) then
                        table.insert(tabla, f(i))
                end
        end

-- Si se omite g(i,v), entonces la table comprehension 
-- equivale a:

        for i in string.gmatch(origen, 'patrón') do
                table.insert(tabla, f(i))
        end

-- Se deben tener en cuenta los patrones que se utilizan
-- en la función string.gmatch()

-- ejemplo

        texto = 'var1, var2, var3,var4,var5,var6, var'
        t = _{'i',texto, '%d+','i%2==0'}
        table.print(t)
		--> { 2, 4, 6}

-- En este ejemplo se uso el patrón '%d+'  para  que  la
-- función string.gmatch() devolviera las  coincidencias
-- con digitos.
-- con g(i)  =  'i%2==0',  se  garantizo  que  solo  las 
-- coincidencias pares se guardaran en la tabla

-- Para generar una tabla sin origen de datos, con una
-- secuencia:

        s = _{'f(i)', seq,{inicio,final,saltos}, 'g(i)'}

-- Este código equivale a:

        for i = inicio, final, saltos do
                if 'g(i)' then
                        table.insert(tabla, f(i))
                end
        end

-- Si se omite 'g(i)':

        for i = inicio, final, saltos do
                table.insert(tabla, f(i))
        end

-- ejemplo

        s = _{'math.floor (i^2)', seq,{2,20,2}, 'i%4==0'}
        table.print(s)
		--> { 16, 64, 144, 256, 400}
