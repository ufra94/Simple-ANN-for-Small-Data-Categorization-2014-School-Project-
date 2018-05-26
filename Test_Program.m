clc
clear

%--------------------------------------------------------------------------
% Load Bobot hasil pelatihan dari file Bobot_Trainning.mat
%--------------------------------------------------------------------------

load AI.mat

InputTest = xlsread('Data_2.xlsx') % Data Testing Input
OutputTest = xlsread('Output_2.xlsx') % Data Testing Output

JumData = length(InputTest(:,1));
JumBenar = 0;
JumSalah = 0;
for i=1:JumData,
	CP = InputTest(i,:);
	A1 = [];
	for ii=1:JHneuron,
		v  = CP*W1(:,ii);
		A1 = [A1 1/(1+exp(-v))];
	end
	A2 = [];
	for jj=1:JOneuron,
		v  = A1*W2(:,jj);
		A2 = [A2 1/(1+exp(-v))];
	end

	%----------------------------------------
	% Pemetaan A2 menjadi kelas keputusan
	% Jika A2 < 0.5 maka Kelas = 0
    % Jika A2 > 0.5 maka Kelas = 1
	%----------------------------------------
	for jj=1:JOneuron,
		if A2(jj) < 0.5,
			Kelas = 0;
		else
			Kelas = 1;
		end
	end

	if Kelas==OutputTest(i),
		JumBenar = JumBenar + 1;
    else
        JumSalah = JumSalah + 1;
	end
end

display(JumBenar);
display(JumSalah);
display(['Akurasi JST = ' num2str(JumBenar/JumData)]);





InputTest1 = xlsread('Data_1.xlsx') % Data Testing Input
OutputTest1 = xlsread('Output_1.xlsx') % Data Testing Output

JumData = length(InputTest1(:,1));
JumBenar = 0;
JumSalah = 0;
for i=1:JumData,
	CP = InputTest1(i,:);
	A1 = [];
	for ii=1:JHneuron,
		v  = CP*W1(:,ii);
		A1 = [A1 1/(1+exp(-v))];
	end
	A2 = [];
	for jj=1:JOneuron,
		v  = A1*W2(:,jj);
		A2 = [A2 1/(1+exp(-v))];
	end


	for jj=1:JOneuron,
		if A2(jj) < 0.5,
			Kelas = 0;
		else
			Kelas = 1;
		end
	end

	if Kelas==OutputTest1(i),
		JumBenar = JumBenar + 1;
    else
        JumSalah = JumSalah + 1;
	end
end

display(JumBenar);
display(JumSalah);
display(['Akurasi JST dengan data training= ' num2str(JumBenar/JumData)]);
