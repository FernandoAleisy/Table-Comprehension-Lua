dofile('ext.lua')
cls()

---------------------------------
---- list comprehension de python

function _(LC)
	local tabla = {}
	local cuerpo = LC[1]
	local datos = LC[2]
	local complemento = LC[3]
	local condicion = LC[4]
	func = load('return function(i,v) return '..cuerpo..' end')
	a, resultado = pcall(func)
	if condicion == nil then
		if type(datos) == 'string' then
			for i in string.gmatch(datos, complemento) do
				table.insert(tabla, resultado(i))
			end
		else
			if type(complemento) == 'string' then
				complemento = string.gsub(complemento, ' ', '')
				for i,v in _G[complemento](datos) do
					table.insert(tabla, resultado(i,v))
				end
			else
				local inicio = complemento[1]
				local final = complemento[2]
				local seq = complemento[3] or 1
				for i = inicio, final, seq do
					table.insert(tabla, resultado(i,v))
				end
			end
		end
	else
		funcCond = load('return function(i,v) return '..condicion..' end')
		b, fcond = pcall(funcCond)
		if type(datos) == 'string' then
			for i in string.gmatch(datos, complemento) do
				if fcond(i) then
					table.insert(tabla, resultado(i))
				end
			end
		else
			if type(complemento) == 'string' then
				complemento = string.gsub(complemento, ' ', '')
				for i,v in _G[complemento](datos) do
					if fcond(i,v) then
						table.insert(tabla, resultado(i,v))
					end
				end
			else
				local inicio = complemento[1]
				local final = complemento[2]
				local seq = complemento[3] or 1
				for i = inicio, final, seq do
					if fcond(i,v) then
						table.insert(tabla, resultado(i,v))
					end
				end
			end
		end
	end
	func = nil
	a = nil
	resultado = nil
	funcCond = nil
	b = nil
	fcond = nil
	return(tabla)
end
