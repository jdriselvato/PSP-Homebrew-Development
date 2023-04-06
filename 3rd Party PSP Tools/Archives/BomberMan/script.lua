--System.usbDiskModeActivate()

-- Cores
red   = Color.new(255, 0, 0)
black = Color.new(0, 0, 0)
white = Color.new(255,255,255)
blue  = Color.new(0,0,255)
green = Color.new(0,255,0)

-- Sons

SNDitem = Sound.load("Sons/Item.wav")
SNDexplosao = Sound.load("Sons/Explosao.wav")

-- Imagens

-- Menu
IMGmenu     = Image.load("Imagens/Menu.png")
IMGponteiro = Image.load("Imagens/Ponteiro.png")
IMGpressO   = Image.load("Imagens/PressO.png")

-- Fundo
IMGfundo1 = Image.load("Imagens/Fundo1.png")
IMGfundo2 = Image.load("Imagens/Fundo2.png")

--Paredes
IMGparedeI  = Image.load("Imagens/Paredes/ParedeI.png")
IMGparedeD1 = Image.load("Imagens/Paredes/ParedeD1.png")
IMGparedeD2 = Image.load("Imagens/Paredes/ParedeD2.png")
IMGparedeD3 = Image.load("Imagens/Paredes/ParedeD3.png")

--Chao
IMGchao = Image.load("Imagens/Chao.png")

--Bomba
IMGbomba1 = Image.load("Imagens/Bomba/B1.png")
IMGbomba2 = Image.load("Imagens/Bomba/B2.png")
IMGbomba3 = Image.load("Imagens/Bomba/B3.png")

--Chamas
IMGchamaC1  = Image.load("Imagens/Explosao/C1.png")
IMGchamaMH1 = Image.load("Imagens/Explosao/MH1.png")
IMGchamaMV1 = Image.load("Imagens/Explosao/MV1.png")
IMGchamaFE1 = Image.load("Imagens/Explosao/FE1.png")
IMGchamaFD1 = Image.load("Imagens/Explosao/FD1.png")
IMGchamaFC1 = Image.load("Imagens/Explosao/FC1.png")
IMGchamaFB1 = Image.load("Imagens/Explosao/FB1.png")

--Items
IMGitemBomba1  = Image.load("Imagens/Itens/Bomba1.png")
IMGitemBomba2  = Image.load("Imagens/Itens/Bomba2.png")

IMGitemChama1  = Image.load("Imagens/Itens/Chama1.png")
IMGitemChama2  = Image.load("Imagens/Itens/Chama2.png")

IMGitemEscudo1 = Image.load("Imagens/Itens/Escudo1.png")
IMGitemEscudo2 = Image.load("Imagens/Itens/Escudo2.png")

IMGitemPatins1 = Image.load("Imagens/Itens/Patins1.png")
IMGitemPatins2 = Image.load("Imagens/Itens/Patins2.png")

-- Protecao
IMGprotecao1 = Image.load("Imagens/Outros/Protecao1.png")
IMGprotecao2 = Image.load("Imagens/Outros/Protecao2.png")
IMGprotecao3 = Image.load("Imagens/Outros/Protecao3.png")
IMGprotecao4 = Image.load("Imagens/Outros/Protecao4.png")

-- Direcao

Parado   = 0
Esquerda = 1
Direita  = 2
Cima	   = 3
Baixo    = 4

-- BomberMan

BomberMan = {
		  [1] = {
				IMG = {
					  B1 = Image.load("Imagens/BomberMan/BM1 - B1.png"),
					  B2 = Image.load("Imagens/BomberMan/BM1 - B2.png"),
					  B3 = Image.load("Imagens/BomberMan/BM1 - B3.png"),
					  C1 = Image.load("Imagens/BomberMan/BM1 - C1.png"),
					  C2 = Image.load("Imagens/BomberMan/BM1 - C2.png"),
					  C3 = Image.load("Imagens/BomberMan/BM1 - C3.png"),
					  E1 = Image.load("Imagens/BomberMan/BM1 - E1.png"),
					  E2 = Image.load("Imagens/BomberMan/BM1 - E2.png"),
					  E3 = Image.load("Imagens/BomberMan/BM1 - E3.png"),
					  D1 = Image.load("Imagens/BomberMan/BM1 - D1.png"),
					  D2 = Image.load("Imagens/BomberMan/BM1 - D2.png"),
					  D3 = Image.load("Imagens/BomberMan/BM1 - D3.png")
					},

                        vivo = true,
				numMovi = 1,				   
				x = 30,
				y = 30,
				posX = 2,
				posY = 2,
				direcao = Parado,
				velo = 3,
				numBombas = 1,
				tamanhoChama = 1,
				caveira = false,
				tempoCaveira = 0,
				disparar = true,
				chutar = false,
				speedUP = false,
				tempoProtecao = 0,
				numMoviProtecao = 1,

			      bomba = {
					   [1] = {
					           activa  = false,	    
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },

					   [2] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [3] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [4] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [5] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [6] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [7] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [8] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    }

				         }
			   },

		  [2] = {
				IMG = {
					  B1 = Image.load("Imagens/BomberMan/BM2 - B1.png"),
					  B2 = Image.load("Imagens/BomberMan/BM2 - B2.png"),
					  B3 = Image.load("Imagens/BomberMan/BM2 - B3.png"),
					  C1 = Image.load("Imagens/BomberMan/BM2 - C1.png"),
					  C2 = Image.load("Imagens/BomberMan/BM2 - C2.png"),
					  C3 = Image.load("Imagens/BomberMan/BM2 - C3.png"),
					  E1 = Image.load("Imagens/BomberMan/BM2 - E1.png"),
					  E2 = Image.load("Imagens/BomberMan/BM2 - E2.png"),
					  E3 = Image.load("Imagens/BomberMan/BM2 - E3.png"),
					  D1 = Image.load("Imagens/BomberMan/BM2 - D1.png"),
					  D2 = Image.load("Imagens/BomberMan/BM2 - D2.png"),
					  D3 = Image.load("Imagens/BomberMan/BM2 - D3.png")
					},

                        vivo = true,
				numMovi = 1,
				x = 330,
				y = 210,
				posX = 2,
				posY = 2,
				direcao = Parado,
				velo = 3,
				numBombas = 1,
				tamanhoChama = 1,
				caveira = false,
				tempoCaveira = 0,
				disparar = true,
				chutar = false,
				speedUP = false,
				tempoProtecao = 0,
				numMoviProtecao = 1,

			      bomba = {
					   [1] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },

					   [2] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [3] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [4] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [5] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [6] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [7] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    },
					   [8] = {
					           activa = false,
						     posX = 0,
						     posY = 0,
						     tamanhoChama = 1,
						     tempoExplosao = 0
						    }

				         }

			     }

		  }


Nivel = {}

-- Duração da Chama Activa...
tempoCA = 10

-- Contador
TempoJogo = 180 -- 180s = 3Min
SegAux = 1

-- Controladores de Jogo
Sair  = false
Jogar = false
tecla = 0

--------------------------------------------------------------- // -----------------------------------

-- Mover BomberMan
function Mover_BM (index)

   local posAux = (BomberMan[index].posY-1)*13 + BomberMan[index].posX

   local MoveuB = false
   local MoveuC = false
   local MoveuE = false
   local MoveuD = false

   tecla = Controls.read()
	
   -- Deslocação
   if tecla:down() then

	if (math.mod(BomberMan[index].x,30)==0) then
		
	   if (math.mod(BomberMan[index].y,30)==0) then

		if (Nivel[posAux+13] == 4) or (Nivel[posAux+13] >= 8) then -- Paredes ou Itens...

		   BomberMan[index].y	    = BomberMan[index].y + BomberMan[index].velo
		   BomberMan[index].posY    = BomberMan[index].posY + 1 
		   BomberMan[index].direcao = Baixo
		   BomberMan[index].numMovi = 1

		end

		MoveuB = true

	   else

		BomberMan[index].y = BomberMan[index].y + BomberMan[index].velo
		BomberMan[index].numMovi = BomberMan[index].numMovi + 1

		if BomberMan[index].numMovi > 4  then
	
               BomberMan[index].numMovi = 1

		end
		
		if (BomberMan[index].direcao == Cima) then

		   BomberMan[index].posY    = BomberMan[index].posY + 1
		   BomberMan[index].direcao = Baixo
		   BomberMan[index].numMovi = 1

		end

		MoveuB = true

	   end
	
	end

   end -- Baixo

   if tecla:up() then

	if (math.mod(BomberMan[index].x,30)==0) then
		
	   if (math.mod(BomberMan[index].y,30)==0) then

		if (Nivel[posAux-13] == 4) or (Nivel[posAux-13] >= 8) then

		   BomberMan[index].y	    = BomberMan[index].y - BomberMan[index].velo
		   BomberMan[index].posY    = BomberMan[index].posY - 1 
		   BomberMan[index].direcao = Cima
		   BomberMan[index].numMovi = 5

		end

		MoveuC = true

	   else

		BomberMan[index].y = BomberMan[index].y - BomberMan[index].velo
		
		BomberMan[index].numMovi = BomberMan[index].numMovi + 1

		if BomberMan[index].numMovi > 8 then
	
               BomberMan[index].numMovi = 5

		end

		if (BomberMan[index].direcao == Baixo) then

		   BomberMan[index].posY    = BomberMan[index].posY - 1
		   BomberMan[index].direcao = Cima
		   BomberMan[index].numMovi = 5

		end

		MoveuC = true

	   end
	
	end

   end -- Cima

   if tecla:left() then

	if (math.mod(BomberMan[index].y,30)==0) then
		
	   if (math.mod(BomberMan[index].x,30)==0) then

		if (Nivel[posAux-1] == 4) or (Nivel[posAux-1] >= 8) then

		   BomberMan[index].x	    = BomberMan[index].x - BomberMan[index].velo
		   BomberMan[index].posX    = BomberMan[index].posX - 1 
		   BomberMan[index].direcao = Esquerda
		   BomberMan[index].numMovi = 9

		end

		MoveuE = true

	   else

		BomberMan[index].x = BomberMan[index].x - BomberMan[index].velo

		BomberMan[index].numMovi = BomberMan[index].numMovi + 1

		if BomberMan[index].numMovi > 12  then
	
               BomberMan[index].numMovi = 9

		end
		
		if (BomberMan[index].direcao == Direita) then

		   BomberMan[index].posX    = BomberMan[index].posX - 1
		   BomberMan[index].direcao = Esquerda
		   BomberMan[index].numMovi = 9

		end

		MoveuE = true

	   end
	
	end

   end -- Esquerda

   if tecla:right() then

	if (math.mod(BomberMan[index].y,30)==0) then
		
	   if (math.mod(BomberMan[index].x,30)==0) then

		if (Nivel[posAux+1] == 4) or (Nivel[posAux+1] >= 8) then

		   BomberMan[index].x	    = BomberMan[index].x + BomberMan[index].velo
		   BomberMan[index].posX    = BomberMan[index].posX + 1 
		   BomberMan[index].direcao = Direita
		   BomberMan[index].numMovi = 13

		end

		MoveuD = true

	   else

		BomberMan[index].x = BomberMan[index].x + BomberMan[index].velo

		BomberMan[index].numMovi = BomberMan[index].numMovi + 1
		
		if BomberMan[index].numMovi > 16  then
	
               BomberMan[index].numMovi = 13

		end

		if (BomberMan[index].direcao == Esquerda) then

		   BomberMan[index].posX    = BomberMan[index].posX + 1
		   BomberMan[index].direcao = Direita
		   BomberMan[index].numMovi = 13
		   
		end

		MoveuD = true

	   end

	end

   end -- Direita

---------------------- // ----------------------

   -- Caso movimento = false, "Corrigir"...

   -- Baixo
   if (tecla:down()) and (MoveuB == false) then
	   
	if (BomberMan[index].direcao == Direita) and (MoveuD == false) then

	   BomberMan[index].x = BomberMan[index].x + BomberMan[index].velo

	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 16  then
	
            BomberMan[index].numMovi = 13

	   end

	elseif (BomberMan[index].direcao == Esquerda) and (MoveuE == false) then

	   BomberMan[index].x = BomberMan[index].x - BomberMan[index].velo
		
	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 12 then
	
            BomberMan[index].numMovi = 9

	   end

	end

   end 

   -- Cima
   if (tecla:up()) and (MoveuC == false) then
	   
	if (BomberMan[index].direcao == Direita) and (MoveuD == false) then

	   BomberMan[index].x = BomberMan[index].x + BomberMan[index].velo

	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 16  then
	
            BomberMan[index].numMovi = 13

	   end

	elseif (BomberMan[index].direcao == Esquerda) and (MoveuE == false) then

	   BomberMan[index].x = BomberMan[index].x - BomberMan[index].velo
		
	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 12 then
	
            BomberMan[index].numMovi = 9

	   end

	end

   end 

   -- Esquerda
   if (tecla:left()) and (MoveuE == false) then

	if (BomberMan[index].direcao == Baixo) and (MoveuB == false) then

	   BomberMan[index].y = BomberMan[index].y + BomberMan[index].velo

	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 4  then
	
            BomberMan[index].numMovi = 1

	   end

	elseif (BomberMan[index].direcao == Cima) and (MoveuE == false) then

	   BomberMan[index].y = BomberMan[index].y - BomberMan[index].velo
		
	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 8 then
	
            BomberMan[index].numMovi = 5

	   end

	end

   end

   -- Direita
   if (tecla:right()) and (MoveuD == false) then

	if (BomberMan[index].direcao == Baixo) and (MoveuB == false) then

	   BomberMan[index].y = BomberMan[index].y + BomberMan[index].velo

	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 4  then
	
            BomberMan[index].numMovi = 1

	   end

	elseif (BomberMan[index].direcao == Cima) and (MoveuE == false) then

	   BomberMan[index].y = BomberMan[index].y - BomberMan[index].velo
		
	   BomberMan[index].numMovi = BomberMan[index].numMovi + 1

	   if BomberMan[index].numMovi > 8 then
	
            BomberMan[index].numMovi = 5

	   end

	end

   end

---------------------- // ----------------------

   -- Disparar...
   if (tecla:cross()) and (BomberMan[index].diparar == true) then

	Criar_Bomba(index)
      BomberMan[index].diparar = false

   end

   -- Libertar Disparo...
   if not tecla:cross() then

      BomberMan[index].diparar = true

   end

end -- Mover BomberMan

-- Criar Bomba
function Criar_Bomba(numBM)
   
   local i = 0
   local posAux = (BomberMan[numBM].posY-1)*13+BomberMan[numBM].posX 

   if Nivel[posAux]==4 then

	 for i =1,BomberMan[numBM].numBombas do

	   if BomberMan[numBM].bomba[i].activa == false then

		 BomberMan[numBM].bomba[i].activa = true
		 BomberMan[numBM].bomba[i].direcao = Parado

		 BomberMan[numBM].bomba[i].posX = BomberMan[numBM].posX
		 BomberMan[numBM].bomba[i].posY = BomberMan[numBM].posY

		 BomberMan[numBM].bomba[i].tamanhoChama  = BomberMan[numBM].tamanhoChama
		 BomberMan[numBM].bomba[i].tempoExplosao = 3

		 -- Actualizar Nível...

		 Nivel[posAux] = 5 -- Chão c/ Bomba...

		 i = BomberMan[numBM].numBombas

	   end

	 end

   end

end -- Criar Bomba

-- Destruir Bomba
function Destruir_Bomba(numBM,numBomba)

   local posAux = (BomberMan[numBM].bomba[numBomba].posY-1)*13+BomberMan[numBM].bomba[numBomba].posX

   BomberMan[numBM].bomba[numBomba].activa = false

   SNDexplosao:play()
   Criar_Chamas(posAux,BomberMan[numBM].bomba[numBomba].tamanhoChama)

end -- Destruir Bomba

-- Criar Chamas
function Criar_Chamas(pos,tamanhoChama)
 
   local BateuE = false
   local BateuD = false
   local BateuC = false
   local BateuB = false
   local posAux = 0

   -- Centro da Explosão
   Nivel[pos] = 8

   tempoCA = 10
   
   for i = 1,tamanhoChama do

	-- Esquerda	
	if (BateuE == false) then

	   if ((Nivel[pos-i] == 0) or ((Nivel[pos-i] >= 1) and (Nivel[pos-i] <= 3))) then -- Paredes

	      if (Nivel[pos-i] >= 1) and (Nivel[pos-i] <= 3) then

		   Nivel[pos-i] = 2

	      end

	      BateuE = true

	   elseif (Nivel[pos-i] == 4) then -- Chão

	      if i~=tamanhoChama then

		   Nivel[pos-i]= 11
	      else
		   Nivel[pos-i]= 14

	      end

	   elseif (Nivel[pos-i] >= 5) and (Nivel[pos-i] <= 7) then -- Chão c/ Bomba

		for j=1,2 do

		   for k=1,BomberMan[j].numBombas do

			posAux = (BomberMan[j].bomba[k].posY-1)*13 + BomberMan[j].bomba[k].posX
			
			if (BomberMan[j].bomba[k].activa == true) and (posAux==pos-i) then

			   BomberMan[j].bomba[k].tempoExplosao = 0

			   Destruir_Bomba(j,k)

			   k = BomberMan[j].numBombas
			   j = 2

			end

		   end

		end

		BateuE = true

	   elseif (Nivel[pos-i] >= 29) and (Nivel[pos-i] <= 38) then -- Chão c/ Item

		Nivel[pos-i] = 4

		BateuE = true

	   end

      end

	-- Direita
	if (BateuD == false) then

	   if ((Nivel[pos+i] == 0) or ((Nivel[pos+i] >= 1) and (Nivel[pos+i] <= 3))) then -- Parede

	      if (Nivel[pos+i] >= 1) and (Nivel[pos+i] <= 3) then

		   Nivel[pos+i] = 2

	   	end

	   	BateuD = true

	   elseif (Nivel[pos+i] == 4) and (BateuD == false) then -- Chão

	   	if i~=tamanhoChama then

		   Nivel[pos+i]= 11
	   	else
		   Nivel[pos+i]= 17

	   	end

	   elseif (Nivel[pos+i] >= 5) and (Nivel[pos+i] <= 7) then -- Chão c/ Bomba

		for j=1,2 do

		   for k=1,BomberMan[j].numBombas do

			posAux = (BomberMan[j].bomba[k].posY-1)*13 + BomberMan[j].bomba[k].posX
			
			if (BomberMan[j].bomba[k].activa == true) and (posAux==pos+i) then

			   BomberMan[j].bomba[k].tempoExplosao = 0

			   Destruir_Bomba(j,k)

			   k = BomberMan[j].numBombas
			   j = 2

			end

		   end

		end

		BateuD = true

	   elseif (Nivel[pos+i] >= 29) and (Nivel[pos+i] <= 38) then -- Chão c/ Item

		Nivel[pos+i] = 4

		BateuD = true

	   end

	end

	-- Cima
	if (BateuC == false) then

	   if ((Nivel[pos-i*13] == 0) or ((Nivel[pos-i*13] >= 1) and (Nivel[pos-i*13] <= 3))) then -- Parede

	   	if (Nivel[pos-(i*13)] >= 1) and (Nivel[pos-(i*13)] <= 3) then

		   Nivel[pos-(i*13)] = 2

	   	end

	   	BateuC = true

	   elseif (Nivel[pos-i*13] == 4) and (BateuC == false) then -- Chão

	      if i~=tamanhoChama then

		   Nivel[pos-i*13]= 26
	      else
		   Nivel[pos-i*13]= 20

	      end

	   elseif (Nivel[pos-i*13] >= 5) and (Nivel[pos-i*13] <= 7) then -- Chão c/ Bomba

		for j=1,2 do

		   for k=1,BomberMan[j].numBombas do

			posAux = (BomberMan[j].bomba[k].posY-1)*13 + BomberMan[j].bomba[k].posX
			
			if (BomberMan[j].bomba[k].activa == true) and (posAux==(pos-i*13)) then

			   BomberMan[j].bomba[k].tempoExplosao = 0

			   Destruir_Bomba(j,k)

			   k = BomberMan[j].numBombas
			   j = 2

			end

		   end

		end

		BateuC = true

	   elseif (Nivel[pos-i*13] >= 29) and (Nivel[pos-i*13] <= 38) then -- Chão c/ Item

		Nivel[pos-i*13] = 4

		BateuC = true

	   end

	end

	-- Baixo
	if (BateuB == false) then

	   if ((Nivel[pos+i*13] == 0) or ((Nivel[pos+i*13] >= 1) and (Nivel[pos+i*13] <= 3))) then -- Parede

	   	if (Nivel[pos+i*13] == 1) and (Nivel[pos+i*13] <= 3) then

		   Nivel[pos+i*13] = 2

	   	end

	   	BateuB = true

	   elseif (Nivel[pos+i*13] == 4) and (BateuB == false) then -- Chão

	   	if i~=tamanhoChama then

		   Nivel[pos+i*13]= 26
	   	else
		   Nivel[pos+i*13]= 23

	      end

	   elseif (Nivel[pos+i*13] >= 5) and (Nivel[pos+i*13] <= 7) then -- Chão c/ Bomba

		for j=1,2 do

		   for k=1,BomberMan[j].numBombas do

			posAux = (BomberMan[j].bomba[k].posY-1)*13 + BomberMan[j].bomba[k].posX
			
			if (BomberMan[j].bomba[k].activa == true) and (posAux==(pos+i*13)) then

			   BomberMan[j].bomba[k].tempoExplosao = 0

			   Destruir_Bomba(j,k)

			   k = BomberMan[j].numBombas
			   j = 2

			end

		   end

		end

		BateuB = true

	   elseif (Nivel[pos+i*13] >= 29) and (Nivel[pos+i*13] <= 38) then -- Chão c/ Item

		Nivel[pos+i*13] = 4

		BateuB = true

	   end

	end

   end

end -- Criar Chamas

-- Actualizar Chamas
function Actualizar_Chamas()

   for i =1,117 do

	if (Nivel[i] >= 8) and (Nivel[i] <= 28) then

	   Nivel[i]=4

	end
   end

end -- Actualizar Chamas

-- Criar Item
function Criar_Item()

   local rand= math.random(10)

   if (rand == 1) or (rand == 2) or (rand == 3) or (rand == 4) then

   	return (29)

   elseif (rand == 5) then

   	return (31)

   elseif (rand == 6) or (rand == 7) or (rand == 8) then

   	return (33)

   elseif (rand == 9) or (rand == 10)  then

   	return (35)

   end

end -- Criar Item

-- Desenhar Nivel
function Desenhar_Nivel()

   local linha=0
   local coluna=0

   for i=1,117 do

	if Nivel[i]	== 0 then

	   screen:blit(45+30*coluna,30*linha,IMGparedeI)

	elseif Nivel[i]==1 then

	   screen:blit(45+30*coluna,30*linha,IMGparedeD1)

	elseif Nivel[i]==2 then

	   screen:blit(45+30*coluna,30*linha,IMGparedeD2)

	   if tempoCA == 5 then

		Nivel[i] = 3

	   end

	elseif Nivel[i]==3 then

	   screen:blit(45+30*coluna,30*linha,IMGparedeD3)

	   if tempoCA == 0 then

		if (math.random(2) == 1) then
			
		   Nivel[i] = Criar_Item()
		else
		   Nivel[i] = 4

		end

	   end

	elseif Nivel[i]==4 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)

	elseif Nivel[i]==5 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGbomba1)

	elseif Nivel[i]==6 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGbomba2)

	elseif Nivel[i]==7 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGbomba3)

	elseif Nivel[i]==8 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaC1)

	elseif Nivel[i]==9 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaC2)

	elseif Nivel[i]==10 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaC3)

	elseif Nivel[i]==11 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMH1)

	elseif Nivel[i]==12 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMH2)

	elseif Nivel[i]==13 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMH3)

	elseif Nivel[i]==14 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFE1)

	elseif Nivel[i]==15 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFE2)

	elseif Nivel[i]==16 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFE3)

	elseif Nivel[i]==17 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFD1)

	elseif Nivel[i]==18 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFD2)

	elseif Nivel[i]==19 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFD3)

	elseif Nivel[i]==20 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFC1)

	elseif Nivel[i]==21 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFC2)

	elseif Nivel[i]==22 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFC3)

	elseif Nivel[i]==23 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFB1)

	elseif Nivel[i]==24 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFB2)

	elseif Nivel[i]==25 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaFB3)

	elseif Nivel[i]==26 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMV1)

	elseif Nivel[i]==27 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMV2)

	elseif Nivel[i]==28 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGchamaMV3)

	elseif Nivel[i]==29 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemBomba1)

	   Nivel[i] = 30

	elseif Nivel[i]==30 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemBomba2)

	   Nivel[i] = 29

	elseif Nivel[i]==31 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemPatins1)

	   Nivel[i] = 32

	elseif Nivel[i]==32 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemPatins2)

	   Nivel[i] = 31

	elseif Nivel[i]==33 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemChama1)

	   Nivel[i] = 34

	elseif Nivel[i]==34 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemChama2)

	   Nivel[i] = 33

	elseif Nivel[i]==35 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemEscudo1)

	   Nivel[i] = 36


	elseif Nivel[i]==36 then

	   screen:blit(45+30*coluna,30*linha,IMGchao)
	   screen:blit(45+30*coluna,30*linha,IMGitemEscudo2)

	   Nivel[i] = 35

	end

	if math.mod(i,13)==0 then

	   linha=linha+1
	   coluna=0

	else

	    coluna=coluna+1

	end

   end	

end -- Desenhar Nivel

-- Ler Nivel
function Ler_Nivel(nomeNivel)

   local num = 0

   i = 1

   file = assert(io.open(nomeNivel,"r"))
   num=file:read("*n")

   while num do

	Nivel[i] = num
	i=i+1
	num=file:read("*n")

   end

   file:close()

end -- Ler Nivel


-- Contador
function Contador()

   local tempo = os.date("*t", os.time())
   local posAux = 0
   local i = 0
   local j = 0

   -- Tempo Chama Activa
   if tempoCA > 0 then

	tempoCA = tempoCA - 1
	 if tempoCA == 0 then

	   Actualizar_Chamas()

	 end

   end

   if tempo.sec ~= segAux then

	TempoJogo = TempoJogo - 1
	segAux = tempo.sec

	-- Descontar 1 Segundo à Proteção...
	for i=1,2 do

	   if BomberMan[i].tempoProtecao > 0 then

	      BomberMan[i].tempoProtecao = BomberMan[i].tempoProtecao - 1

		if BomberMan[i].tempoProtecao == 0 then
		
		   BomberMan[i].numMoviProtecao = 1

		end

	   end

	end

	-- Descontar 1 Segundo às Bombas Activas...
	for i =1, 2 do

	   for j=1,BomberMan[i].numBombas do

		if (BomberMan[i].bomba[j].activa == true) then

		   BomberMan[i].bomba[j].tempoExplosao = BomberMan[i].bomba[j].tempoExplosao - 1

		   posAux = (BomberMan[i].bomba[j].posY-1)*13 + BomberMan[i].bomba[j].posX

		   Nivel[posAux] = Nivel[posAux] + 1

		   if (BomberMan[i].bomba[j].tempoExplosao == 0) then

			Destruir_Bomba(i,j)

		   end

		end

	   end

	end

   end

end -- Contador


-- Mostrar BomberMan
function Mostrar_BomberMan(index)

   if BomberMan[index].numMovi == 1 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.B1)

   elseif BomberMan[index].numMovi == 2 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.B2)

   elseif BomberMan[index].numMovi == 3 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.B1)

   elseif BomberMan[index].numMovi == 4 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.B3)

   elseif BomberMan[index].numMovi == 5 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.C1)

   elseif BomberMan[index].numMovi == 6 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.C2)

   elseif BomberMan[index].numMovi == 7 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.C1)

   elseif BomberMan[index].numMovi == 8 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.C3)

   elseif BomberMan[index].numMovi == 9 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.E1)

   elseif BomberMan[index].numMovi == 10 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.E2)

   elseif BomberMan[index].numMovi == 11 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.E1)

   elseif BomberMan[index].numMovi == 12 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.E3)

   elseif BomberMan[index].numMovi == 13 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.D1)

   elseif BomberMan[index].numMovi == 14 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.D2)

   elseif BomberMan[index].numMovi == 15 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.D1)

   elseif BomberMan[index].numMovi == 16 then

	screen:blit(BomberMan[index].x+45,BomberMan[index].y-15,BomberMan[index].IMG.D3)

   end


   --Protecao
   for i=1,1 do

	if (BomberMan[i].tempoProtecao > 0) then

	   if (BomberMan[i].numMoviProtecao >= 1) and (BomberMan[i].numMoviProtecao <= 4) then

		screen:blit(BomberMan[i].x+45,BomberMan[i].y-15,IMGprotecao1)

	   elseif (BomberMan[i].numMoviProtecao >= 5) and (BomberMan[i].numMoviProtecao <= 8) then

		screen:blit(BomberMan[i].x+45,BomberMan[i].y-15,IMGprotecao2)

	   elseif (BomberMan[i].numMoviProtecao >= 9) and (BomberMan[i].numMoviProtecao <= 12) then

		screen:blit(BomberMan[i].x+45,BomberMan[i].y-15,IMGprotecao3)

	   elseif (BomberMan[i].numMoviProtecao >= 13) and (BomberMan[i].numMoviProtecao <= 16) then

		screen:blit(BomberMan[i].x+45,BomberMan[i].y-15,IMGprotecao4)

	   end
	
	   BomberMan[i].numMoviProtecao = BomberMan[i].numMoviProtecao + 1

	   if (BomberMan[i].numMoviProtecao > 16) then 
		
            BomberMan[i].numMoviProtecao = 1

	   end

	end

   end

end -- Mostrar BomberMan

-- Game Over
function Game_Over(resultado)

   screen:clear(black)

   Music.stop()

   if (resultado == 1) then

   	screen:print(175,100,"Player 1 WINS",red)

   elseif (resultado == 2) then

   	screen:print(175,100,"Player 2 WINS",red)

   elseif (resultado == 3) then

   	screen:print(160,100,"DRAW",red)	

   elseif (resultado == 4) then

	screen:print(160,100,"TIME IS OVER - DRAW",red)	

   end

   screen:print(172,120,"Press Triangle",white)	

   screen.waitVblankStart()
   screen.flip()

   while not Controls.read():triangle() do


   end

   Jogar = false

end -- Game Over

-- BomberMan Morreu
function BomberMan_Morreu()

   local posAux = 0

   -- Verificar se Algum BomberMan Morreu
   for i=1, 2 do   
   
	posAux = (BomberMan[i].posY-1)*13 + BomberMan[i].posX

	if (BomberMan[i].tempoProtecao == 0) and (Nivel[posAux] >= 8) and (Nivel[posAux] <= 28) then

	   BomberMan[i].vivo = false

	end

   end

   -- Se algum BomberMan Morreu então GameOver...

   if (BomberMan[1].vivo == true) and (BomberMan[2].vivo == false) and (tempoCA==0) then

      Game_Over(1)

   elseif(BomberMan[1].vivo == false) and (BomberMan[2].vivo == true) and (tempoCA==0) then

      Game_Over(2)

   elseif(BomberMan[1].vivo == false) and (BomberMan[2].vivo == false) and (tempoCA==0) then

	Game_Over(3)

   end

end -- BomberMan Morreu

-- Apanhou Item
function Apanhou_Item(index)

   local posAux = Nivel[(BomberMan[index].posY-1)*13+BomberMan[index].posX]

   if (posAux >= 29) and (posAux <= 38) then

      if ((posAux == 29) or (posAux == 30)) and (BomberMan[index].numBombas < 8) then

	  BomberMan[index].numBombas = BomberMan[index].numBombas + 1

      elseif (posAux == 31) or (posAux == 32) then

	  BomberMan[index].speedUP = true

      elseif (posAux == 33) or (posAux == 34) and (BomberMan[index].tamanhoChama < 3) then

	  BomberMan[index].tamanhoChama = BomberMan[index].tamanhoChama + 1

      elseif (posAux == 35) or (posAux == 36) then
	
	  BomberMan[index].tempoProtecao = 10
	  BomberMan[index].numMoviProtecao = 1

	end

      -- Actualizar Nível (Chão)
      Nivel[(BomberMan[index].posY-1)*13+BomberMan[index].posX] = 4

	SNDitem:play()

   end

end -- Apanhou Item

-- Iniciar Variáveis
function Iniciar_Vars()

   -- BomberMan 1
   BomberMan[1].vivo = true
   BomberMan[1].x = 30
   BomberMan[1].y = 30
   BomberMan[1].posX = 2
   BomberMan[1].posY = 2
   BomberMan[1].direcao = Parado
   BomberMan[1].velo = 5
   BomberMan[1].numBombas = 1
   BomberMan[1].tamanhoChama = 1
   BomberMan[1].caveira = false
   BomberMan[1].tempoCaveira = 0
   BomberMan[1].numMovi = 1
   BomberMan[1].tempoProtecao = 0
   BomberMan[1].numMoviProtecao = 0
   BomberMan[1].diparar = true
   BomberMan[1].chutar = false
   BomberMan[1].speedUP = false
   BomberMan[1].bomba[1].activa = false
   BomberMan[1].bomba[2].activa = false
   BomberMan[1].bomba[3].activa = false

   -- BomberMan 2
   BomberMan[2].vivo = true
   BomberMan[2].x = 330
   BomberMan[2].y = 210
   BomberMan[2].posX = 12
   BomberMan[2].posY = 8
   BomberMan[2].direcao = Parado
   BomberMan[2].velo = 5
   BomberMan[2].numBombas = 1
   BomberMan[2].tamanhoChama = 1
   BomberMan[2].caveira = false
   BomberMan[2].tempoCaveira = 0
   BomberMan[2].numMovi = 1
   BomberMan[2].tempoProtecao = 0
   BomberMan[2].numMoviProtecao = 0
   BomberMan[2].diparar = true
   BomberMan[2].chutar = false
   BomberMan[2].speedUP = false
   BomberMan[2].bomba[1].activa = false
   BomberMan[2].bomba[2].activa = false
   BomberMan[2].bomba[3].activa = false

   -- Tempo Jogo
   TempoJogo = 180 -- 180s = 3Min

end -- Iniciar Variáveis

-- Jogo
function Jogo()

 Iniciar_Vars()
 Ler_Nivel("Mapa.dat")

 Music.playFile("Sons/Musica.xm", true) 

 while (Jogar == true) do
    
   screen:clear()

   --Fundo
   screen:blit(0,0,IMGfundo1)
   screen:blit(435,0,IMGfundo2)

   --Nivel
   Desenhar_Nivel()

   if (BomberMan[1].vivo == true) then

	Mover_BM(1)

   end

   -- Verificar se Morreu algum BomberMan...
   BomberMan_Morreu()

   -- Verificar se BomberMan apanhou algum Item...
   Apanhou_Item(1)
   Apanhou_Item(2)

   -- Mostrar BomberMan's...
   Mostrar_BomberMan(1)
   Mostrar_BomberMan(2)

   -- Se speedUP = true e estiver em "30x30" então aumenta a velocidade...
   for i=1,2 do
	
	if (BomberMan[i].speedUP == true) and (math.mod(BomberMan[i].x,30) == 0) and (math.mod(BomberMan[i].y,30) == 0) then

	   BomberMan[i].velo = 6
	   BomberMan[i].speedUp = false

	end

   end
 
   -- Mostrar TempoJogo, e verificar se o tempo já terminou...
   if TempoJogo == 0 then

	Game_Over(4)
   else
	screen:print(227,10,string.format("%d:%02d",math.abs(TempoJogo/60),math.mod(TempoJogo,60)),black)

   end

   Contador()

   -- Double Buffering
   screen.waitVblankStart(0)
   screen.flip()

 end

 Music.stop()

end -- Jogo

-- Menu
function Menu()

local opcao    = 0
local teclaAux = 0
local pressOx  = 150
local pressOy  = 200
local pressOdirecao = Direita
   
   while (Sair == false) and (Jogar == false) do

	screen:blit(0,0,IMGmenu)

	tecla = Controls.read()

   	if tecla ~= teclaAux then

         if tecla:up() and (opcao == 1) then

	   	opcao = 0

         end

   	   if tecla:down() and (opcao == 0) then

	      opcao = 1

   	   end

   	   if tecla:circle() and (opcao == 0) then

	   	Jogar = true

   	   end

         if tecla:start() then

	   	Sair = true

   	   end   

      end

      teclaAux = tecla

   	if pressOdirecao == Direita then

	   pressOx  = pressOx + 3
   	else
	   pressOx  = pressOx - 3

   	end

   	if pressOx == 210 then

	   pressOdirecao = Esquerda

   	elseif pressOx == 150 then

	   pressOdirecao = Direita

   	end

   	-- Desenhar "pressO"
   	screen:blit(pressOx,200,IMGpressO)

   	-- Desenhar Ponteiro
   	if opcao == 0 then

	   screen:blit(150,100,IMGponteiro)
   	else
	   screen:blit(150,140,IMGponteiro)

   	end

	screen.waitVblankStart(2)
   	screen.flip()
	
   end

end -- Menu

-- Main
while (Sair == false) do

   Sair  = false
   Jogar = false

   Menu()

   if (Jogar == true) then

	Jogo()

   end 

end -- Main
