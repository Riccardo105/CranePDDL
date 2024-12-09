(define (domain crane_domain)

;remove requirements that are not needed
(:requirements :strips  :typing :conditional-effects )

(:types objects physobj - object location
    loading_bay - location
    crane - physobj
    crate - physobj
)



(:predicates 
    (at ?physobj - physobj ?loc - location)
    (connected ?from - location ?to - location)
    (holding ?crate - crate ?crane - crane)
    (free ?crane - crane)
    (top_most ?crate - crate)
    (stacked ?top_crate - crate ?bot_crate - crate)
)

(:action move_crane
    :parameters (?crane - crane ?from - loading_bay ?to - loading_bay)
    :precondition (and (connected ?from ?to) (at ?crane ?from))
    :effect (and (not( at ?crane ?from)) (at ?crane ?to))
)
(:action pick_up_crate
    :parameters (?crate - crate ?below_crate - crate ?crane - crane ?loading_bay - loading_bay)
    :precondition (and (at ?crane ?loading_bay) (free ?crane) (at ?crate ?loading_bay) (top_most ?crate))
    :effect (and (holding ?crate ?crane) (not(at ?crate ?loading_bay)) (not(free ?crane)) 
            (when (stacked ?crate ?below_crate)
                    (and (not (stacked ?crate ?below_crate))
                    (top_most ?below_crate)))
            (not(top_most ?crate))
            )
)

(:action drop_off_crate
    :parameters (?crate - crate ?below_crate - crate ?crane - crane ?loading_bay - loading_bay)
    :precondition (and (at ?crane ?loading_bay) (holding ?crate ?crane) )
    :effect (and (at ?crate ?loading_bay) (top_most ?crate) (not (holding ?crate ?crane)) (free ?crane)
            (when (and (top_most ?below_crate ) ( at ?below_crate ?loading_bay))
                    (and (stacked ?crate ?below_crate)
                    (not (top_most ?below_crate)))))

)
)