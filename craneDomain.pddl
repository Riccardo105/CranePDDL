;Header and description

(define (domain CraneDomain)

;remove requirements that are not needed
(:requirements :strips  :typing :conditional-effects  :fluents)

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

(:functions
    (num_crane_on_bay ?loading_bay - loading_bay)
)
(:action move_crane
    :parameters (?crane - crane ?from - loading_bay ?to - loading_bay)
    :precondition (and (connected ?from ?to) (at ?crane ?from))
    :effect (and (not( at ?crane ?from)) (at ?crane ?to))
)

(:action pick_up_crate
    :parameters (?crate - crate  ?crane - crane ?loading_bay - loading_bay)
    :precondition (and (at ?crane ?loading_bay) (free ?crane) (at ?crate ?loading_bay) (top_most ?crate))
    :effect (and (holding ?crate ?crane) (not(at ?crate ?loading_bay)) (not(free ?crane)) (not(top_most ?crate))
            (forall (?c - crate)
            (when (and  (at ?c ?loading_bay )
                (stacked ?crate ?c)
                )( and (not(stacked ?crate ?c))(top_most ?c)
            )))
            (decrease (num_crane_on_bay ?loading_bay) 1)
            ))

(:action drop_off_crate
    :parameters (?crate - crate  ?crane - crane ?loading_bay - loading_bay)
    :precondition (and (at ?crane ?loading_bay) (holding ?crate ?crane) (>= (num_crane_on_bay ?loading_bay) 3) )
    :effect (and (at ?crate ?loading_bay) (top_most ?crate) (not (holding ?crate ?crane)) (free ?crane) (top_most ?crate)
             (forall (?c - crate)
             (when (and (at ?c ?loading_bay)
                    (top_most ?c)
             )(and (not(top_most ?c)) (stacked ?crate ?c)))
             ) 
             (increase (num_crane_on_bay ?loading_bay) 1)
             ))

)


