const COLORS = Dict(    
    "black" => 0,    
    "brown" => 1,    
    "red" => 2,   
    "orange" => 3,   
    "yellow" => 4,   
    "green" => 5,
    "blue" => 6,  
    "violet" => 7,   
    "grey" => 8,  
    "white" => 9        
)

function colorcode(colors)
    code, place = 0, 1
    for i in 2:-1:1
        code += place*COLORS[colors[i]]
        place *= 10
    end
    code
end