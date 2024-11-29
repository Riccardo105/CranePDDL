
(define (domain crane_domain)
    (:requirements :strips :typing :disjunctive-preconditions :negative-preconditions :action-costs)

    (:types object location physobj - object 
            loading_bay - location  
            crate - physobj
            crane - physobj   ; make sure "crane" is used here
    )

    (:predicates 
        (at ?physobj - physobj ?location - location) ; a physical object is at a location
        (is_heavy ?crate - crate) ; assign weight to crate
        (on_top_of ?crate1 - crate ?crate2 - crate) ; define the stack hierarchy in case of multiple crates in one bay
        (holding ?crane - crane ?crate - crate) ; the crane is holding a crate
        (free ?crane) ; the crane is free
        (connected ?loc1 - location ?loc2 - location) ; define the connections between locations
    )

    (:functions
    (num_crates_on_bay ?loading_bay) ; Define the function for counting crates
    (total_cost) ; calculates total cost to resolve problem
    )

    (:action crane_move
        :parameters ( ?crane - crane ?from - loading_bay ?to - loading_bay) ; a crane must be in location and move to another     
        :precondition (and (connected ?from ?to) (connected ?to ?from)) ; this adds symmetry to connection (2 ways)
        :effect (and (not (at ?crane ?from)) (at ?crane ?to))
    )

    (:action pick_up
    :parameters (?crane - crane ?crate - crate ?loc - loading_bay)
    :precondition (and 
        (at ?crane ?loc) ; the crane must be at the loading bay
        (at ?crate ?loc) ; the crate must be at the loading bay
        (free ?crane) ; the crane must not be holding a crate already
        (not (exists (?other_crate - crate) 
            (on_top_of ?other_crate ?crate))) ; No crate should be on top of the target crate
    )
    :effect (and 
        (holding ?crane ?crate) ; the crane is now holding the crate
        (not (free ?crane)) ; the crane is not free anymore
        (not (at ?crate ?loc)) ; the crate is not at the loading bay
        (decrease (num_crates_on_bay ?loc) 1) ; decrement crate count
        ;; Ensure crate is no longer considered on top of another
        (forall (?other_crate - crate)
            (not (on_top_of ?crate ?other_crate))) ; Remove any stacking relationships involving this crate
    )
)

    (:action drop_off
    :parameters (?crane - crane ?crate - crate ?top_crate - crate ?loc - loading_bay)
    :precondition (and 
        (at ?crane ?loc) ; Crane is at the location
        (holding ?crane ?crate) ; Crane is holding the crate
        (<= (num_crates_on_bay ?loc) 3) ; Check capacity
        (not (on_top_of ?crate ?crate)) ; Prevent self-stacking
        (at ?top_crate ?loc)           ; The top crate is at the same location
        (not (exists (?other_crate - crate)  ; Ensure no other crate is on top of the top crate
            (and (at ?other_crate ?loc) 
            (on_top_of ?other_crate ?top_crate)))))  ; No crate is on top of the top crate

    :effect (and 
        (not (holding ?crane ?crate)) ; Crane releases the crate
        (free ?crane) ; Crane is now free
        (at ?crate ?loc) ; Crate is placed at the location
        (increase (num_crates_on_bay ?loc) 1) ; Update crate count
        ;; Place the crate on top if there are existing crates
        (on_top_of ?crate ?top_crate)
        (increase (total_cost) 2) ; increase total cost
        )
    )
)