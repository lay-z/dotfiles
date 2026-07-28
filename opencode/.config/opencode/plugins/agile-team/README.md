How would you recommend that I set up some automated orchestration?

for example I want to have a pipeline for feature generation that would have the following structure for all 'lanes':

```rust
struct Board {
    url: Url,
    name: String,
    lane: Swimlane,
}

struct Swimlane {
    overview: Text, /// Description of the lane, what happens in this swimlane at a high level
    steps: Array<Step>,
}

struct Step {
    purpose: Array<String>
    skills: Array<Skill?>
    tools: Array<Tool>
    agents: Array<Agent> //
    outcomes: Array<Outcome>
    prompt: String
}

/// Being able to point to a skill to load, before executing prompt
struct Skill {
    file: Path,
    description: str,
    keywords: [String],
}

/// A way of describing a CLI tool which the agent is able to work with / use
struct Tool {
    binary: path, /// Regex which is used to determine if agent cannot run the command, if it it empty, nothing is denied
}
```

# Swimlanes

## Filling out the details of ticket on "$github_board"

1. I provide a ticket with some infromation on it. This ticket exists on github (agent can use the github cli tool locally to be able to fetch.
   - Purpose, get into the mind of the customer
     - to understand the business use case. With the mind of the user of this feature,
     - why are they interacting with it, for what do they need to do,
     - how technically competent are they.
   - Skills (information sheets)
     How github CLI works (like the arguments etc, maybe we can just have `gh --help` output in there. So then as tool changes, so does how to use it.
   - Access to tools (Which methods / actions can the agent take):
     - "gh \*"
     - "gh \*"
   - Agent type:
     scrum master agent? unsure if a technical role would also be required to try and build out technical capability? or if this would be done in later tickets, first we need to just
   - Outcome:
     - A ticket on the 'ready' column from ${ github_board } (board needs to be placed in a config value somewhere)
     - A message on slack channel that only me and summit are on, informing us of a ticket that needs to be rated by:
       - severity
       - impact on the roadmap
       - BONUS POINTS - If I can get it so that it submits a poll, me and sumit vote (without the other seeing the value, and then we do a bit of discussion why we think our value is correct, then we vote again. Keep doing voting rounds until convergence)

## Technical architecture

2. Read ticket and tries to build technical solution to solve issue
   - Purpose, to build out a specification that can be reviewed at a highlevel from a human.
     Steps:
     - Research through out the code base for any similar concepts that exist in the code base (e.g. if the ticket mentions partners, then search through the code base for all bits of code related to partners, but in a way that helps to understand where best to make adjustments)
       - Brainstorm technical approaches - Run it three times with subagent, however tell next agent it can't solve the way previous agent solved. Has to be serial
     - Select best approach, but allow for user to specify their prefered approach, in the case of high in quality of idea
       - why are they interacting with it, for what do they need to do,
       - how technically competent are they.
     - Skills (information sheets)
       How github CLI works (like the arguments etc, maybe we can just have `gh --help` output in there. So then as tool changes, so does how we use it.
   - Access to tools (Which methods / actions can the agent take):
     - "gh \*"
     - "gh \*"
   - Agent type:
     scrum master agent? unsure if a technical role would also be required to try and build out technical capability? or if this would be done in later tickets, first we need to just

## Development

    First round

### Store breakdown of task, why and how it was implemented. Do this to correspond to the merged commit or the squashed commit of the branch after merging into '$branch'
