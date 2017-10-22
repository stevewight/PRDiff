# PRDiff 
<p>Hello 🙂 Procore</p>
This was an interesting challenge and I enjoyed getting a chance to work with the Github API!  There were additional things I would have loved to do given more time.

## Goal of the app
- List all Pull Requests for a given repo
- Display a Pull Requests diff when tapped on

## Architecture 🏛
- GithubAPI
  - For interacting with the Github api

### ViewControllers
- PullRequestVC
  - Loads and Displays all the repos PullRequests (PR)
- DiffVC
  - Displays the diff from a given (tapped on) PR
  
### Models
🎉 I used Swift 4's new __Decodable__ protocol for parsing json -> models from Github 🎉
- PullRequest
  - represents a github pull request
- User
  - represents a github user
- Repo
  - represents a github repo
- Diff
  - group of Diff objects for handling parsed Diff structure
  - DiffFile -> DiffBlock -> DiffLine -> DiffLineInfo -> DiffOperation(+,-)
- DiffParser
  - parses the raw diff from github into the above Diff structure

### Views
All the apps views are built with code and I tried to leverage 🔥UIStackViews🔥 when possible
- AvatarImageView
  - Custom UIImageView for displaying github user image (or icon)
- PullRequestCell
  - For displaying a single pull request
- PullRequestStack
  - Custom nested UIStackView to help structure the PullRequestCell
- DiffCell
  - For displaying a single diff line
- DiffStack
  - Custom nested UIStackView to help structure the DiffCell

### ViewModels
- PullRequestVM
- (TODO:) DiffVM

### Extensions
- UIExtensions
  - For helper methods on UIImage and String

## Additional TODOs 🤔
Additional things that could be done with more time on the project:
- Continue display of diff with split view, file headers, block seperation
  - DiffCell is already prepared
  - Diff structure has already been parsed
- AlertView for displaying error messages to the user
- Repo search rather then having one hard coded in
- Custom loading indicator view for VC network calls
- Additional viewModel refactors
- Refactor of GithupAPI to use a more extensible structure
  - Something similar to Alamofires URLRequestConvertable for routing
- More animations and UI enhancements
- etc...  

## Thanks! 😁
For taking the time to look over my code and any feedback is appreciated.  It would be great to chat more about my approach and answer any questions you might have!
