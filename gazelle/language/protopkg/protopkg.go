package protopkg

import (
	"flag"
	"fmt"

	"github.com/bazelbuild/bazel-gazelle/config"
	gzflag "github.com/bazelbuild/bazel-gazelle/flag"
	"github.com/bazelbuild/bazel-gazelle/label"
	"github.com/bazelbuild/bazel-gazelle/language"
	"github.com/bazelbuild/bazel-gazelle/repo"
	"github.com/bazelbuild/bazel-gazelle/resolve"
	"github.com/bazelbuild/bazel-gazelle/rule"
)

// NewLanguage is called by Gazelle to install this language extension in a
// binary.
func NewLanguage() language.Language {
	return NewProtoPkgLanguage("protopkg")
}

// NewProtoPkgLanguage create a new ProtoPkgLanguage Gazelle extension implementation.
func NewProtoPkgLanguage(name string) *ProtoPkgLanguage {
	return &ProtoPkgLanguage{
		name:     name,
		resolver: newResolver(),
	}
}

// ProtoPkgLanguage implements language.Language.
type ProtoPkgLanguage struct {
	name                       string
	protoRepositoryImportsFile []string
	resolver                   *resolver
}

// Name returns the name of the language. This should be a prefix of the kinds
// of rules generated by the language, e.g., "go" for the Go extension since it
// generates "go_library" rules.
func (pl *ProtoPkgLanguage) Name() string { return pl.name }

// The following methods are implemented to satisfy the
// https://pkg.go.dev/github.com/bazelbuild/bazel-gazelle/resolve?tab=doc#Resolver
// interface, but are otherwise unused.
func (l *ProtoPkgLanguage) RegisterFlags(fs *flag.FlagSet, cmd string, c *config.Config) {
	fs.Var(&gzflag.MultiFlag{Values: &l.protoRepositoryImportsFile}, "proto_repository_imports_file", "path to a proto_repository imports.csv file")
}

func (l *ProtoPkgLanguage) CheckFlags(fs *flag.FlagSet, c *config.Config) error {
	for _, filename := range l.protoRepositoryImportsFile {
		if err := l.loadProtoRepositoryImports(filename); err != nil {
			return fmt.Errorf("loading imports %q: %w", filename, err)
		}
	}

	return nil
}

func (l *ProtoPkgLanguage) loadProtoRepositoryImports(filename string) error {
	if err := l.resolver.LoadFile(filename); err != nil {
		return fmt.Errorf("loading proto_repository imports file %q: %w", filename, err)
	}
	return nil
}

func (*ProtoPkgLanguage) KnownDirectives() []string { return nil }

// Configure implements config.Configurer
func (pl *ProtoPkgLanguage) Configure(c *config.Config, rel string, f *rule.File) {}

// Kinds returns a map of maps rule names (kinds) and information on how to
// match and merge attributes that may be found in rules of those kinds. All
// kinds of rules generated for this language may be found here.
func (*ProtoPkgLanguage) Kinds() map[string]rule.KindInfo {
	return nil
}

// Loads returns .bzl files and symbols they define. Every rule generated by
// GenerateRules, now or in the past, should be loadable from one of these
// files.
func (pl *ProtoPkgLanguage) Loads() []rule.LoadInfo { return nil }

// Fix repairs deprecated usage of language-specific rules in f. This is called
// before the file is indexed. Unless c.ShouldFix is true, fixes that delete or
// rename rules should not be performed.
func (*ProtoPkgLanguage) Fix(c *config.Config, f *rule.File) {}

// Imports returns a list of ImportSpecs that can be used to import the rule r.
// This is used to populate RuleIndex.
//
// If nil is returned, the rule will not be indexed. If any non-nil slice is
// returned, including an empty slice, the rule will be indexed.
func (pl *ProtoPkgLanguage) Imports(c *config.Config, r *rule.Rule, f *rule.File) []resolve.ImportSpec {
	return nil
}

// Embeds returns a list of labels of rules that the given rule embeds. If a
// rule is embedded by another importable rule of the same language, only the
// embedding rule will be indexed. The embedding rule will inherit the imports
// of the embedded rule. Since SkyLark doesn't support embedding this should
// always return nil.
func (*ProtoPkgLanguage) Embeds(r *rule.Rule, from label.Label) []label.Label { return nil }

// Resolve translates imported libraries for a given rule into Bazel
// dependencies. Information about imported libraries is returned for each rule
// generated by language.GenerateRules in language.GenerateResult.Imports.
// Resolve generates a "deps" attribute (or the appropriate language-specific
// equivalent) for each import according to language-specific rules and
// heuristics.
func (pl *ProtoPkgLanguage) Resolve(
	c *config.Config,
	ix *resolve.RuleIndex,
	rc *repo.RemoteCache,
	r *rule.Rule,
	importsRaw interface{},
	from label.Label,
) {
}

// GenerateRules extracts build metadata from source files in a directory.
// GenerateRules is called in each directory where an update is requested in
// depth-first post-order.
//
// args contains the arguments for GenerateRules. This is passed as a struct to
// avoid breaking implementations in the future when new fields are added.
//
// A GenerateResult struct is returned. Optional fields may be added to this
// type in the future.
//
// Any non-fatal errors this function encounters should be logged using
// log.Print.
func (pl *ProtoPkgLanguage) GenerateRules(args language.GenerateArgs) language.GenerateResult {
	return language.GenerateResult{}
}