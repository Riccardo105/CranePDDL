(define (problem CraneProblem) (:domain CraneDomain)
(:objects 
    crane - crane
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
    crate5 - crate
    crate6 - crate
    crate7 - crate
    crate8 - crate
    

    bay1 - loading_bay
    bay2 - loading_bay
    bay3 - loading_bay
    bay4 - loading_bay

)

(:init

    ;; location of all physobj in the environment
    (at crane bay1)
    (at crate1 bay4)
    (at crate2 bay4)
    (at crate3 bay3)
    (at crate4 bay3)
    (at crate5 bay2)
    (at crate6 bay2)
    (at crate7 bay2)
    (at crate8 bay2)


    ; initially crane is empty 
    (free crane)

    ;; connections between bays for crane movements (both-ways)
    (connected bay1 bay2)
    (connected bay2 bay1)
    (connected bay2 bay3)
    (connected bay3 bay2)
    (connected bay3 bay4)
    (connected bay4 bay3)

    

    ; top most crate in each bay (if there is one)
    (top_most crate2)
    (top_most crate4)
    (top_most crate8)

    ; stacking hierarchy for crates on same bay
    (stacked crate2 crate1)
    (stacked crate4 crate3)
    (stacked crate6 crate5)
    (stacked crate7 crate6)
    (stacked crate8 crate7)
    
    (= (num_crane_on_bay bay1) 0)
    (= (num_crane_on_bay bay2) 4)
    (= (num_crane_on_bay bay3) 2)
    (= (num_crane_on_bay bay4) 2)

    
)

(:goal (and
    (stacked crate2 crate1)
    (stacked crate3 crate2)
    
))

)
