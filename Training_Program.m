clc
clear

Input = xlsread('Data_1.xlsx') % Data Trainning Input
Output = xlsread('Output_1.xlsx') % Data Trainning Output

JumData  = length(Input(:,1));	% Jumlah data trainning (banyak baris data)
JumInput  = length(Input(1,:));	% Jumlah data input (banyak kolom data)
JOneuron = length(Output(1,:));	% Jumlah neurons pada Output layer

JHneuron = 2;			% Jumlah neurons pada Hidden layer
LR       = 0.005;		% Learning Rate
Epoch	 = 35;          % Maksimum iterasi
MaxMSE	 = 0.0001;		% Maksimum MSE

W1 = [];
for ii=1:JHneuron,
	W1 = [W1 ; (rand(1,JumInput)*2-1)];
end
W1 = W1';


W2 = [];
for jj=1:JOneuron,
	W2 = [W2 ; (rand(1,JHneuron)*2-1)];
end
W2 = W2';

MSEepoch = MaxMSE + 1;  % MSE untuk 1 epoch
MSE = [];               % List MSE untuk seluruh epoch
ee = 1;                 % Index Epoch

while (ee <= Epoch) & (MSEepoch > MaxMSE)
	MSEepoch = 0;
    if (ee>1000), LR=0.004; end
	for i=1:JumData,
		CP = Input(i,:);	% Current Input
		CT = Output(i,:);   % Current Output

		%-----------------------------------------------------------
		% Propagasi Maju untuk mendapatkan Output, Error, dan MSE
        % Fungsi aktivasi yang digunakan : sigmoid
		%-----------------------------------------------------------
		A1=[];
		for ii=1:JHneuron,
			v  = CP*W1(:,ii);
			A1 = [A1 1/(1+exp(-v))];
		end
		A2=[];
		for jj=1:JOneuron,
			v  = A1*W2(:,jj);
			A2 = [A2 1/(1+exp(-v))];
		end
		Error = CT - A2;

		for kk=1:length(Error),
			MSEepoch = MSEepoch + Error(kk)^2;
        end
        
		%-----------------------------------------------------------
		% Propagasi Mundur untuk update Bobot (W1 dan W2)
		%-----------------------------------------------------------
		for kk=1:JOneuron,
			D2(kk) = A2(kk) * (1-A2(kk)) * Error(kk);
		end
		dW2 = [];
		for jj=1:JHneuron,
			for kk=1:JOneuron,
				delta2(kk) = LR * D2(kk) * A1(jj);
			end
			dW2 = [dW2 ; delta2];
		end
		for jj=1:JHneuron,
			D1(jj) = A1 * (1-A1)' * D2 * W2(jj,:)';
		end
		dW1 = [];
		for ii=1:JumInput,
			for jj=1:JHneuron,
				delta1(jj) = LR * D1(jj) * CP(ii);
			end
			dW1 = [dW1 ; delta1];
		end
		W1 = W1 + dW1;	% W1 baru
		W2 = W2 + dW2;	% W2 baru
	end
	MSE = [MSE (MSEepoch/JumData)];
	ee  = ee + 1;
end

plot(MSE);
xlabel('Epoch')
ylabel('MSE')
display(MSE);
display(W1);
display(W2);

save AI.mat W1 W2 MSE JHneuron JOneuron LR