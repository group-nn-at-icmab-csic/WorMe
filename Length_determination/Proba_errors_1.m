% Comprenent els errors en MATLAB

disp("Hola")
try

    disp(2+2)

    % Dona error:
    josep diu que print (2 + 2)
catch ME
    % Captura el error y muestra el mensaje
    disp('Se capturó un error:');
    disp(ME.message);
    disp(ME)
end

