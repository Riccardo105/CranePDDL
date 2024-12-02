(define (problem crane_problem_2) (:domain crane_domain)

(:objects 
    crane - crane
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
    crate5 - crate
    crate6 - crate

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
    (at crate5 bay3)
    (at crate6 bay3)

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
    (top_most crate6)

    ; stacking hierarchy for crates on same bay
    (stacked crate2 crate1)
    (stacked crate4 crate3)
    (stacked crate5 crate4)
    (stacked crate6 crate5)

    ; initial number of crates per bay
    (= (num_crates_on_bay bay1) 0)
    (= (num_crates_on_bay bay2) 0)
    (= (num_crates_on_bay bay3) 4)
    (= (num_crates_on_bay bay4) 2)
)

(:goal (and
    (top_most crate1)
    (not(top_most crate2))
))

)
