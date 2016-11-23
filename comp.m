%this is for multiple images classification

% f=fopen('result.txt','wt');
cd('./Images/test/out_manmade_1k')
images=dir('*.jpg');
n=length(images); 
for i=1:n
    result_i=classify(images(i).name);
    result(1,i)=result_i;
    
%     fprintf(f, ['out_manmade_1k/' images(i).name ' ' num2str(result_i) '\n']);
%     i
end

cd('../out_natural_1k')
images=dir('*.jpg');
n=length(images); 
for i=1:n
    result_i=classify(images(i).name);
    result(2,i)=result_i;
%     fprintf(f, ['out_natural_1k/' images(i).name ' ' num2str(result_i) '\n']);
%     i+250
end
% fclose(f);

