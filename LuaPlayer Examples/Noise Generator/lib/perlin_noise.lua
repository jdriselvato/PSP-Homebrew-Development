-- Generate a random permutation table
local permutation = {}
for i = 0, 255 do
    permutation[i] = i
end
for i = 0, 255 do
    local j = math.random(0, 255)
    permutation[i], permutation[j] = permutation[j], permutation[i]
end

-- Calculate the gradient vector
local gradient = {}
for i = 0, 255 do
    local angle = math.random() * 2 * math.pi
    gradient[i] = {math.cos(angle), math.sin(angle)}
end

-- Calculate the dot product
local function dot(a, b)
    return a[1] * b[1] + a[2] * b[2]
end

-- Calculate the fade function
local function fade(t)
    return 6 * t^5 - 15 * t^4 + 10 * t^3
end

-- Calculate the Perlin noise value at a given point
function perlin_noise_2d(x, y)
    -- Calculate the grid cell coordinates
    local xi = math.floor(x)
    local yi = math.floor(y)

    -- Determine the position within the grid cell
    local xf = x - xi
    local yf = y - yi

    -- Calculate the fade values
    local u = fade(xf)
    local v = fade(yf)

    -- Calculate the hash values
    local aa = permutation[(permutation[xi%256] + yi)%256]
    local ab = permutation[(permutation[xi%256] + yi+1)%256]
    local ba = permutation[(permutation[xi+1%256] + yi)%256]
    local bb = permutation[(permutation[xi+1%256] + yi+1)%256]

    -- Calculate the gradient vectors
    local gaa = gradient[aa%256]
    local gab = gradient[ab%256]
    local gba = gradient[ba%256]
    local gbb = gradient[bb%256]

    -- Calculate the dot products
    local d1 = dot(gaa, {xf, yf})
    local d2 = dot(gab, {xf, yf-1})
    local d3 = dot(gba, {xf-1, yf})
    local d4 = dot(gbb, {xf-1, yf-1})

    -- Interpolate the dot products
    local x1 = lerp(d1, d3, u)
    local x2 = lerp(d2, d4, u)
    local y1 = lerp(x1, x2, v)

    return y1
end

-- Linear interpolation function
function lerp(a, b, t)
    return (1 - t) * a + t * b
end