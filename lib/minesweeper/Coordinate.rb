##
# Classe responsável por armazenar as configurações padrões do Jogo.
# @author Laurindo Ferreira Lucio Junior
# @date 24/04/2018 01:37
#
CoordinatePair = Struct.new(:x, :y) do
	def to_a
		[x, y]
	end
end
