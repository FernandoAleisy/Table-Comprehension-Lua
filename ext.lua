-------------------------------------------------------------
-- Función para despejar la consola
cls = function()
	os.execute("cls")
end
-------------------------------------------------------------
-- Extendiendo la clase string:
rawset(
	string,
	'split',
	function(text, sep) 
		if type(text) ~= 'string' then 
			error ('You must add a string as argument') 
		end 
		if sep == nil then 
			sep = "," 
		end 
		local t={} 
		for str in string.gmatch(text, "([^"..sep.."]+)") do 
			table.insert(t, string.match (" "..str.." ", "[^ ].*[ ^]")) 
		end 
		return t 
	end
	)
-------------------------------------------------------------
-- Extendiendo el calse table:

rawset (
	table,
	'print',
	function(self)
		if type(self) ~= 'table' then
			error ('You must add a table as argument')
		end
		local auxiliar = {}
		for i, v in pairs(self) do
			if type(i) == 'number' then
				if type(v) == "table" then
					table.insert(auxiliar, ' '..table.print(v))
				else
					table.insert(auxiliar, ' '..v)
				end
			else
				if type(v) == "table" then
					table.insert(auxiliar,  " "..i.." = "..table.print(v))
				else
					table.insert(auxiliar,  " "..i.." = "..v)
				end
			end
		end
		return "{"..table.concat( auxiliar, ",").."}"
	end
	)

rawset(
	table,
	'keys',
	function(self)
		if not ( type(self) == 'table' ) then
			error ('You must add a table as argument')
		end
		local keysT = {}
		for i, _ in pairs(self) do
			table.insert(keysT,i) 
		end
		return keysT
	end
	) 

rawset(
	table,
	'values',
	function(self) 
		if not ( type(self) == 'table' ) then 
			error ('You must add a table as argument') 
		end 
		local valuesT = {} 
		for _, v in pairs(self) do 
			if type(v) == "table" then 
				table.insert(valuesT,table.print(v)) 
			else table.insert(valuesT,v) 
			end
		end
		return valuesT
	end
	)

rawset(
	table,
	'mover',
	function(...)
		local arg = {...}
		local origen = arg[1]
		local destino = arg[#arg]
		if type(_G[origen]) ~= 'table' and type(_G[destino]) ~= 'table' then
			error ('The first two arguments must be tables')
		end
		arg[1] = nil
		arg[#arg] = nil
		for _,v in pairs(arg) do
			_G[destino][v] = _G[origen][v]
			_G[origen][v] = nil
		end
	end
	)

rawset (
	table,
	'sum',
	function(self) 
		local resultado = 0
		for _,v in pairs(self) do 
			resultado = resultado + v
		end
		return resultado
	end
	)
-------------------------------------------------------------