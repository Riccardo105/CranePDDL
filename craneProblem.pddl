(define (problem crain_problem) (:domain crane_domain)
        
        (:objects 
            bay1 - loading_bay
            bay2 - loading_bay
            bay3 - loading_bay
            bay4 - loading_bay
            crate1 - crate
            crate2 - crate
            crate3 - crate
            crate4 - crate
            crane - crane
        )

        (:init
            (at crane bay1) ; the crane is in bay 1
            (free crane) ; the crane isn't holding anything

            ; initialising bays connections
            (connected bay1 bay2) 
            (connected bay2 bay3)
            (connected bay3 bay4)

            ; assigning weight to crates
            (is_heavy crate2)
            (is_heavy crate4)

            ; initialising crate positioning
            (at crate1 bay2)
            (at crate2 bay3)
            (at crate3 bay4)
            (at crate4 bay4)

            ; defining stacking for crates on same bay
            (on_top_of crate4 crate3)

            ;setting number of crate on bays
            (= (num_crates_on_bay  bay1) 0)
            (= (num_crates_on_bay  bay2) 1)
            (= (num_crates_on_bay  bay3) 1)
            (= (num_crates_on_bay  bay4) 2)

        )

        (:goal (and
                ; crates 1 2 3 are stacked in ascendant order
                (on_top_of crate3 crate2) 
                (on_top_of crate2 crate1)
                (exists (?loading_bay - loading_bay) (at crate1 ?loading_bay))
        )
    )
)
