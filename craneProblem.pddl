(define (problem crane_problem_2) (:domain crane_domain)

(:objects 
    crane - crane
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
    

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

    ; stacking hierarchy for crates on same bay
    (stacked crate2 crate1)
    (stacked crate4 crate3)

    
)

(:goal (and
    (stacked crate3 crate2)
    (stacked crate1 crate1)
    (top_most crate3)
    (exists (?loading_bay1 - loading_bay ?laoding_bay2 - loading_bay)
     (and (at crate1 ?loading_bay1) 
          (at crane ?laoding_bay2)
          (not(= ?loading_bay1 ?laoding_bay2))
     ))
))

)
