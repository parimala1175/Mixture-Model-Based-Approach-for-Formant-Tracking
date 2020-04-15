function p = norm_density_student(x, mu, sigma,v)
distance=((x-mu).^2)/sigma;
p = gamma((v+1)/2)./((sqrt(sigma*pi*v)*gamma(v/2)*((1+(distance./v)).^((v+1)/2))));

end