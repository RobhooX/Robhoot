function EffFront_Alex()

  tic;
  
  leerDeArchivo=true;
  if leerDeArchivo,
    load('Stocks.mat');
  else
%     %leer lista de nombres de stocks
%     
    fid=fopen('YahooStocks_NASDAQ.txt');
    StockNamesData=textscan(fid,'%s %s','delimiter','\t');
    fclose(fid);
    sNames=StockNamesData{1}(1:3:end);
%     NamesAux=StockNamesData{1}; %primer columna
%             
%     NamesAux1=cellfun(@(x) {textscan(x,'%s %s','delimiter','/')},NamesAux);
%     tickers=cellfun(@(x) x{2}, NamesAux1);
%     
%     %bajo los datos de Yahoo
%     data = getYahooDailyData(tickers,'01/01/2015', '31/12/2015', 'dd/mm/yyyy');
    %sNames={'YHOO', 'AMZN', 'TSLA', 'GOOG', 'FCFS', 'AAPL'};
    data = getYahooDailyData(sNames,'01/01/2015', '31/12/2015', 'dd/mm/yyyy');
    save('datos.mat','data');
    %whos '-file' 'datos.mat';
  end

  stockNames=fieldnames(data);
  cantStocks=length(stockNames);
  
  %   %Parametros
  cantCarteras=100000;  
  nroSenC=20;  %Cant de Stocks en Cartera
  maxCombStocks=nchoosek(cantStocks,nroSenC)
  pause
  %ALE: probar nchoosek([1:6],3) para generar todas las posibles
  %combinaciones de 3 entre 6...
  %Actualmente genero combinaciones al azar...
  
  cantCombStocks=1000; %maxCombStocks; %1;    %Cant de combinaciones de stocks en las carteras...
  nroMaxComposiciones=ceil(cantCarteras/cantCombStocks); %Cant Composiciones por combinaci�n de Stocks 

  
  
  
%   %data.AMZN.Properties;
%   rendimiento.AMZN=(data.AMZN.Close-data.AMZN.Open)./data.AMZN.Open;
%   %hist(rendimiento.AMZN,20)
%   rendimiento.TSLA=(data.TSLA.Close-data.TSLA.Open)./data.TSLA.Open;
  
  
  Rendimientos=[];
  for ixS=1:cantStocks,
    % calcular todas las series temporales de los rendimientos,....
    sData=getfield(data,stockNames{ixS});
    Rendimientos(1:size(sData),end+1)=(sData.Close-sData.Open)./sData.Open;    
  end
  CM=cov(Rendimientos); %Covariance Matrix CM
  PromRend=mean(Rendimientos); %Promedio de los rendimientos
  
%   %Parametros
%   cantCarteras=10;  
%   nroSenC=cantStocks;  %Cant de Stocks en Cartera
%   cantCombStocks=1;    %Cant de combinaciones de stocks en las carteras...
%   nroMaxComposiciones=cantCarteras/cantCombStocks; %Cant Composiciones por combinaci�n de Stocks 

  figure;
  hold on;
  
  ixC=0;
  while(ixC<cantCarteras),
    % selecciono los stocks que van a la cartera...
    p=randperm(cantStocks,nroSenC); %permutaci�n (combinacion) de stocks en cartera
    %calculo las proporciones de los stocks
    w=zeros(nroSenC,1);
    for ixComp=1:nroMaxComposiciones,
      %Genero composici�n de proporciones de Stocks en la cartera...
      wAcum=0;
      for ixS=1:nroSenC-1,        
        w(ixS)=unifrnd(0,1-wAcum);
        wAcum=wAcum+w(ixS);
      end
      w(end)=1-wAcum;
      %fin composicion de la cartera...
      ixC=ixC+1;
      
      %muestro la cartera...
      %disp(ixC);
      %disp(w');
      fprintf('Car %4d ( %s: %f%%',ixC, stockNames{p(1)}, w(1));
      for ix=2:length(p),
        fprintf(', %s: %f%%', stockNames{p(ix)}, w(ix));
      end
      fprintf(')\n');
      %fin muestra...
      
      %calculo Rendimiento y Riesgo de Cartera...
      RendiC=PromRend(p)*w;
%       RendiC=0;      
%       for ix=1:length(p),
%         RendiC=RendiC+w(ix)*PromRend(p(ix));
%       end
      
      RiesgC=sqrt(w'*CM(p,p)*w);  %ALE: verificar esto...
      %ploteo la cartera...
      scatter(RiesgC,RendiC,10,[1 0 0],'filled');
      hola=1;
    end
  end
  toc;
  hola=1;
end