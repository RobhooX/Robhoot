using Makie

scene = Scene();
function xy_data(x, y)
    r = sqrt(x^2 + y^2)
    r == 0.0 ? 1f0 : (sin(r)/r)
end

r = LinRange(-2, 2, 50)
surf_func(i) = [Float32(xy_data(x*i, y*i)) for x = r, y = r]
z = surf_func(20)
surf = surface!(scene, r, r, z)[end]

wf = wireframe!(scene, r, r, Makie.lift(x-> x .+ 1.0, surf[3]),
    linewidth = 2f0, color = Makie.lift(x-> to_colormap(x)[5], surf[:colormap])
)
N = 150
scene
record(scene, "animated_surface_and_wireframe.mp4", LinRange(5, 40, N)) do i
    surf[3] = surf_func(i)
end

